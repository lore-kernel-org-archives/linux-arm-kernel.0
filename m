From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 5 Nov 2012 08:30:15 +0100
Subject: [PATCH 0/2 v2] net: at91_ether add dt and pinctrl support
Message-ID: <20121105073015.GM19021@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	v2: fix typo in doc + miising empty line

	This patch serie add dt and pinctrl support to the at91 ether

	this is need to use the network on at91rm9200 as we now have dt
	support on it

Jean-Christophe PLAGNIOL-VILLARD (2):
      net: at91_ether: add dt support
      net: at91_ether: add pinctrl support

 Documentation/devicetree/bindings/net/cdns-emac.txt |   23 +++++++++++++++++++++++
 drivers/net/ethernet/cadence/at91_ether.c           |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 100 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/cdns-emac.txt

Best Regards,
J.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
