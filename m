From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 4 Nov 2012 16:49:54 +0100
Subject: [PATCH 0/2] net: at91_ether add dt and pinctrl support
Message-ID: <20121104154954.GJ19021@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	This patch serie add dt and pinctrl support to the at91 ether

	this is need to use the network on at91rm9200 as we now have dt
	support on it

Jean-Christophe PLAGNIOL-VILLARD (2):
      net: at91_ether: add dt support
      net: at91_ether: add pinctrl support

 Documentation/devicetree/bindings/net/cdns-emac.txt |   23 +++++++++++++++++++++++
 drivers/net/ethernet/cadence/at91_ether.c           |   83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 99 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/cdns-emac.txt

Best Regards,
J.
