From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Feb 2017 15:44:47 -0600
Subject: [PATCH v6 07/14] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
In-Reply-To: <3a4ce2fd25ed812482b0fc96f50dd305c8f40fe9.1487091464.git-series.gregory.clement@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <3a4ce2fd25ed812482b0fc96f50dd305c8f40fe9.1487091464.git-series.gregory.clement@free-electrons.com>
Message-ID: <20170222214447.bsa466vfiqa24kmw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 06:01:47PM +0100, Gregory CLEMENT wrote:
> From: Hu Ziji <huziji@marvell.com>
> 
> Marvell Xenon SDHC can support eMMC/SD/SDIO.
> Add Xenon-specific properties.
> Also add properties for Xenon PHY setting.
> 
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 172 +++++++-
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt

Acked-by: Rob Herring <robh@kernel.org>
