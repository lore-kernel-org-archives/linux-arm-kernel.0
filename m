From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 17 Jul 2018 10:40:28 +0800
Subject: [PATCH V2] ARM: dts: make pfuze switch always-on for imx platforms
In-Reply-To: <AM3PR04MB1315B66212D928D7EAF27557F5580@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1530063055-25914-1-git-send-email-Anson.Huang@nxp.com>
 <AM3PR04MB1315B66212D928D7EAF27557F5580@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <20180717024027.GA4576@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 02:16:55AM +0000, Anson Huang wrote:
> Hi, Shawn
> 	Although the commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch") is reverted to avoid the boot failure on some i.MX platforms, but adding the "regulator-always-on" property for those pfuze's critical switches are the right way and making sense, no matter how the pfuze regulator's switch ON/OFF function will be implemented, below patches should can be applied anyway?
> 
> ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
> ARM: dts: make pfuze switch always-on for imx platforms
> ARM: dts: imx6sl-evk: keep sw4 always on
> 
> 	Let me know your thoughts, thanks!

Okay, resend them as a series with commit log updated, since the commit
log doesn't reflect the current situation any longer.

Shawn
