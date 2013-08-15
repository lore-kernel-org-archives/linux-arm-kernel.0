From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 15 Aug 2013 10:42:21 +0100
Subject: [PATCH 0/2] ARM DT cpus/cpu and topology bindings
Message-ID: <1376559743-31848-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patch resumes DT topology/cpu bindings discussions for ARM that were
started here:

https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-April/031725.html
https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-April/032450.html

They have been partially reviewed but following the new DT bindings approval
guidelines are still to be debated and updated accordingly.

Given the dependency on booting protocol in-kernel docs for ARM v8, I left on
purpose the method "spin-table" in the cpu node "enable-method" property
to kickstart a proper discussion on the subject before taking a definite
action on it.

Comments very welcome.

Lorenzo

Lorenzo Pieralisi (2):
  Documentation: devicetree: arm: cpus/cpu nodes bindings updates
  Documentation: DT: arm: define CPU topology bindings

 Documentation/devicetree/bindings/arm/cpus.txt     | 424 ++++++++++++++++--
 Documentation/devicetree/bindings/arm/topology.txt | 492 +++++++++++++++++++++
 2 files changed, 869 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/topology.txt

-- 
1.8.2.2
