From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 May 2013 17:11:43 +0100
Subject: [GIT PULL] ARM DT topology bindings
Message-ID: <20130517161143.GA4855@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant, Rob,

since it looks like we reached agreement on DT topology bindings for ARM
please pull the bindings documentation so that code relying on the
topology to be published and set in stone can be released and can stabilize.

The topology documentation relies on updates to the cpus/cpu nodes bindings
that I have just posted:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/169083.html

I do not know if you prefer to merge both documents at once or we can merge
this document first waiting for the other patchset to get merged, please
let me know.

Thank you very much indeed,
Lorenzo

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://linux-arm.org/linux-2.6-lp.git dt-topology

for you to fetch changes up to 9cb1b6c8d59f09e51c87ac812b83d0350151ed3b:

  Documentation: DT: arm: define CPU topology bindings (2013-05-17 16:40:12 +0100)

----------------------------------------------------------------
Lorenzo Pieralisi (1):
      Documentation: DT: arm: define CPU topology bindings

 Documentation/devicetree/bindings/arm/topology.txt | 492 +++++++++++++++++++++
 1 file changed, 492 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/topology.txt
