From: jamesjj.liao@mediatek.com (James Liao)
Date: Mon, 22 Dec 2014 15:46:59 +0800
Subject: [PATCH v2 0/4] clk: mediatek: Add common clock support for
 Mediatek MT8135.
In-Reply-To: <1417675942-10502-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1417675942-10502-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1419234419.24116.7.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2014-12-04 at 14:52 +0800, James Liao wrote:
> This patchset contains the initial common clock support for Mediatek SoCs.
> Mediatek SoC's clock architecture comprises of various PLLs, dividers,
> muxes and clock gates.
> 
> This patchset also contains a basic clock support for Mediatek MT8135.
> 
> This driver is based on 3.18-rc1 + MT8135 basic support.
> 
> James Liao (4):
>   clk: dts: mediatek: add Mediatek MT8135 clock bindings
>   clk: mediatek: Add initial common clock support for Mediatek SoCs.
>   clk: mediatek: Add basic clocks for Mediatek MT8135.
>   dts: mediatek: Enable clock support for Mediatek MT8135.
> 

Hi,

Any comment for this patchset?


Best regards,
James
