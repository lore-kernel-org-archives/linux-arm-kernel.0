From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 2 Feb 2018 09:26:36 +0800
Subject: [PATCH v4 0/6] ARM: dts: Add PHYTEC phyCORE-i.MX 6 and
 phyBOARD-Mira carrier board support
In-Reply-To: <1515421758-4240-1-git-send-email-s.riedmueller@phytec.de>
References: <1515421758-4240-1-git-send-email-s.riedmueller@phytec.de>
Message-ID: <20180202012634.GE20833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 03:29:12PM +0100, Stefan Riedmueller wrote:
> Christian Hemp (2):
>   ARM: dts: imx6: Add support for phyBOARD-Mira i.MX 6Quad/Dual RDK
>   ARM: dts: imx6: Add support for phyBOARD-Mira i.MX 6 DualLight/Solo
>     RDK
> 
> Enrico Scholz (1):
>   ARM: dts: imx6: Add support for phyBOARD-Mira with i.MX 6QuadPlus
> 
> Stefan Riedmueller (3):
>   ARM: dts: imx6: Add initial support for phyCORE-i.MX 6 SOM
>   ARM: dts: imx6: Add initial support for phyBOARD-Mira

Applied above 5 patches.

>   ARM: imx_v6_v7_defconfig: Enable Dialog Semiconductor DA9062 driver

This one doesn't apply to my imx/defconfig branch.  Can you please
rebase?  Thanks.

Shawn
