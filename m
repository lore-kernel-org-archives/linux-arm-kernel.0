From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 16 Sep 2013 12:21:02 +0100
Subject: [PATCH v2 0/2] ARM DT cpus/cpu and topology bindings
Message-ID: <1379330464-27917-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/192322.html

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

 Documentation/devicetree/bindings/arm/cpus.txt     | 391 +++++++++++++++--
 Documentation/devicetree/bindings/arm/topology.txt | 474 +++++++++++++++++++++
 2 files changed, 818 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/topology.txt

-- 
1.8.2.2
