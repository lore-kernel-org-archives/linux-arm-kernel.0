From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 23:20:06 +0800
Subject: [PATCH V2] ARM: dts: imx6ul iomuxc syscon is compatible to imx6q
In-Reply-To: <AM3PR04MB1315C6AE3AC95A1150DB04D7F5E10@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1472480743-8405-1-git-send-email-Anson.Huang@nxp.com>
 <20160829143447.GV30790@tiger>
 <AM3PR04MB1315C6AE3AC95A1150DB04D7F5E10@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <20160829152006.GZ30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 02:44:47PM +0000, Yongcai Huang wrote:
> This patch is to set the GINT bit for all low power mode transition.
> 
> Do we decide to go with PSCI for all i.MX6 SoCs? Currently i.MX6UL's suspend is
> already supported with non-PCSI method, only i.MX7D uses PSCI, right? If we decide
> to implement all power management feature with PSCI, then yes, all these changes
> can be put into PSCI. But since current suspend/cpuidle function are already supported
> using old method, this bit must be set to avoid system goes into low power mode
> unexpected.

My apology.  I messed up it with i.MX7D.  Patch applied, thanks.

Shawn
