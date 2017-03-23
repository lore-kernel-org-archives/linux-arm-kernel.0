From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 23 Mar 2017 15:13:11 +0100
Subject: [PATCH 0/2] IPU PRE/PRG devicetree nodes
Message-ID: <20170323141313.11241-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

the following 2 patches add the DT nodes for the PRE/PRG units found
on i.MX6QP. The bindings and driver code to make use of those are
already in Dave Airlies drm-next branch, so can be considered stable.

Regards,
Lucas

Lucas Stach (2):
  ARM: dts: imx6qp: add PRE nodes
  ARM: dts: imx6qp: add PRG nodes and hook up to IPUs

 arch/arm/boot/dts/imx6qp.dtsi | 58 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

-- 
2.11.0
