From: davem@davemloft.net (David Miller)
Date: Tue, 20 Jun 2017 13:23:23 -0400 (EDT)
Subject: [PATCH 0/4] net-next: stmmac: dwmac-sun8i: add support for V3s
In-Reply-To: <20170617140737.41951-1-icenowy@aosc.io>
References: <20170617140737.41951-1-icenowy@aosc.io>
Message-ID: <20170620.132323.46663908524667004.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>
Date: Sat, 17 Jun 2017 22:07:33 +0800

> Allwinner V3s features an EMAC like the on in H3, but without external MII
> interfaces, so being not able really to use RMII/RGMII.
> 
> And it has a different default value of syscon (0x38000 instead of 0x58000
> on H3), which shows a problem that the EMAC clock freq should be 24MHz.
> (Both H3 and V3s SoCs doesn't have extra xtal input for EPHY, and the
> main xtal is 24MHz. The default value of H3 is set to 24MHz, but the V3s
> default value is set to 25MHz).
> 
> First two patches are device tree binding patches, the third forces
> the frequency to 24MHz and the fourth really add the V3s support.

Series applied to net-next, thanks!
