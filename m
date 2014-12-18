From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 18 Dec 2014 11:33:32 +0100
Subject: [PATCH RFC v2 06/14] ARM: dts: imx6qdl: Move existing MIPI DSI
 ports into a new 'ports' node
In-Reply-To: <1418886696-11636-7-git-send-email-Ying.Liu@freescale.com>
References: <1418886696-11636-1-git-send-email-Ying.Liu@freescale.com>
 <1418886696-11636-7-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1418898812.4212.11.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 18.12.2014, 15:11 +0800 schrieb Liu Ying:
> The MIPI DSI node contains some ports which represent possible DRM CRTCs
> it can connect with.  Each port has a 'reg' property embedded.  This
> property will be wrongly interpretted by the MIPI DSI bus driver, because
> the driver will take each subnode which contains a 'reg' property as a
> DSI peripheral device.  This patch moves the existing MIPI DSI ports into
> a new 'ports' node so that the MIPI DSI bus driver may distinguish its
> DSI peripheral device(s) from the existing ports.
> 
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
