From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 26 Sep 2013 10:42:01 +0100
Subject: [PATCH v3 0/2] ARM DT cpus/cpu and topology bindings
Message-ID: <1380188523-20589-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v3 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/198564.html

- v3 changes
	- Updated #address-cells and reg properties requirements for ARM v8

- v2 changes
	- Removed single core cpu-map example
	- Removed OS dependency from cpus/cpu bindings
	- Updated Marvell compatible strings
	- Clarified behaviour on pre ARM v7 uniprocessor systems and updated
	  examples

This patch resumes DT topology/cpu bindings discussions for ARM that were
started here:

https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-April/031725.html
https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-April/032450.html

Comments welcome, thanks,
Lorenzo

Lorenzo Pieralisi (2):
  Documentation: devicetree: arm: cpus/cpu nodes bindings updates
  Documentation: DT: arm: define CPU topology bindings

 Documentation/devicetree/bindings/arm/cpus.txt     | 401 +++++++++++++++--
 Documentation/devicetree/bindings/arm/topology.txt | 474 +++++++++++++++++++++
 2 files changed, 828 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/topology.txt

-- 
1.8.2.2
