# Repository Migration #

# Overview #

This script allows to migrate the XL Deploy Repository backend. The typical use case is to migrate from the default XL Deploy configuration (using Derby & FileSystem) to another backend (eg Full database storage).

# Requirements #

* **XL Deploy requirements**
	* ** XL Deploy (formerly Deployit) **: version 3.9
	
# Installation #

1. Unzip the content of the distribution zip file (xld-repository-migration-${version}.zip) in your XL Deploy server installation.  The xld-repository-migration-${version} directory should now contain:
    * a bin directory with 2 new files migrate.sh and migrate.cmd
    * the repository-migration-${version}.jar
    * a sample directory with 2 sample jackrabbit-repository XML files

Copy the bin script files to the xl-deploy-server/bin directory, and copy the jar file to the xl-deploy-server/lib directory.
2. If necessary, copy the jdbc drivers to the lib/ directory if your repository is plugged on a RDBMS. (eg: ojdbc6.jar if your database is Oracle)

# Execution

1. Configure the new target repository structure `jackrabbit-repository.xml`. Do *not* modify or override the existing file. See the documentation [System Administartion Manual](https://docs.xebialabs.com/xl-deploy/how-to/configure-the-xl-deploy-repository.html#using-a-database).
2. Run the migration script.

```
bin/migrate.sh  -deployitHome <XL Deploy-Server-Home> -jackrabbit-config-file <Path-to-new-configuration-file> -repository-name <Name> -updateDeployitConfiguration
```

### Example

```
bin/migrate.sh  -deployitHome /opt/xebialabs/xl-deploy-5.5.5-server -jackrabbit-config-file ./bin/jackrabbit-mysql-repository.xml  -repository-name migration-to-mysql -updateDeployitConfiguration
```

Once the script has been successfully executed, you should have a new folder in the `SERVER_HOME/<Name>` directory having the <Name>. The ``-updateDeployitConfiguration`` flag updates the ``deployit.conf`` configuration file and copy the new jackrabbit configuration file to the ``conf/`` directory. (previous jackrabbit configuration file is backed up)

# Troubleshooting

* Java out-of-memory errors:  increase the Java memory settings ``-Xmx`` and ``-XXMaxPermSize`` in the ``DEPLOYIT_SERVER_OPTS`` variable in ``migrate.sh`` or ``migrate.cmd``.
* Packet-size-too-large errors (when using a MySQL database):  Increase the ``MaxAllowedPacketSize``  under the [mysqld] tag in the ``my.cnf`` config file, by adding a line such as ``max_allowed_packet=1024m``.  The ``my.cnf`` file may exist in multiple locations, allowing user, local, and general settings; and these locations may differ by OS, distribution, and version.
