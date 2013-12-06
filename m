From: hramrach@gmail.com (Michal Suchanek)
Date: Fri, 6 Dec 2013 21:52:06 +0100
Subject: [linux-sunxi] [PATCH 00/10] net: stmmac: Add sun7i GMAC glue layer
In-Reply-To: <1386350983-13281-1-git-send-email-wens@csie.org>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
Message-ID: <CAOMqctQLnky=K+uhJNVPTGq+MJVNFoG1OW5Zxo7P2MvrRf_Cug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 December 2013 18:29, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi,
>
> This patch series adds Allwinner sun7i support to stmmac.
> The Allwinner sun7i SoC A20 integrates an early version of
> dwmac IP from Synopsys. On top of that is a hardware glue
> layer. This layer needs to be configured before the dwmac
> can be used.

...

> Comments?
>
> Thanks,
>
> wens
>
>
> Chen-Yu Tsai (10):
>   net: stmmac: Enable stmmac main clock when probing hardware
>   net: stmmac: Honor DT parameter to force DMA store and forward mode
>   net: stmmac: Use platform data tied with compatible strings
>   net: stmmac: sunxi platfrom extensions for GMAC in Allwinner A20 SoC's
>   ARM: dts: sun7i: Add GMAC controller node to sun7i DTSI
>   ARM: dts: sun7i: Add pin muxing options for the GMAC
>   ARM: dts: sun7i: cubietruck: Enable the GMAC
>   ARM: dts: sun7i: cubieboard2: Enable GMAC instead of EMAC
>   ARM: dts: sun7i: olinuxino-micro: Enable GMAC instead of EMAC
>   ARM: dts: sun7i: Add ethernet alias for GMAC

Tested-By: Michal Suchanek <hramrach@gmail.com>

Works for me with RGMII and MII phy on top of 3.13rc3.

Thanks

Michal
