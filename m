From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Mon, 6 Aug 2012 20:35:56 +0530
Subject: [PATCH 0/2] Add device tree support for davinci_mdio driver and fix
 cpsw DT binding documentation
Message-ID: <1344265558-5724-1-git-send-email-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for device tree for Davinci MDIO driver and fixes
CPSW DT binding documentation to make it copy pastable to dts file.

This patch set is tested with the following git tree on AM335X Beagle Bone
https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging-cpsw

Mugunthan V N (2):
  drivers: net: ethernet: davince_mdio: device tree implementation
  documentation: dt: bindings: cpsw: fixing the examples for directly
    using it in dts file

 Documentation/devicetree/bindings/net/cpsw.txt     |  101 ++++++++++---------
 .../devicetree/bindings/net/davinci-mdio.txt       |   33 +++++++
 drivers/net/ethernet/ti/davinci_mdio.c             |   41 +++++++-
 3 files changed, 123 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/davinci-mdio.txt
