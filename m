From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 2 Feb 2018 14:06:54 +0800
Subject: [PATCH v5 0/6] ARM: dts: Add PHYTEC phyCORE-i.MX 6 and
 phyBOARD-Mira carrier board support
In-Reply-To: <1515514200-9801-1-git-send-email-s.riedmueller@phytec.de>
References: <1515514200-9801-1-git-send-email-s.riedmueller@phytec.de>
Message-ID: <20180202060653.GK20833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 05:09:54PM +0100, Stefan Riedmueller wrote:
> Changes since v4:
> - Rearranged &m25p80 node in dts files to fit alphabetical order
> - Fixed a parenthesis for uniformity in mira dtsi
> 
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

Okay, I replaced v4 with this v5.

>   ARM: imx_v6_v7_defconfig: Enable Dialog Semiconductor DA9062 driver

This one still doesn't apply to imx/defconfig.  Please rebase and
resend.

Shawn
