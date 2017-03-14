From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 14 Mar 2017 15:12:33 +0800
Subject: [PATCH v2] ARM: dts: imx50: imx50-esdhc use imx53-esdhc
In-Reply-To: <1488488628-11711-1-git-send-email-akurz@blala.de>
References: <1488488628-11711-1-git-send-email-akurz@blala.de>
Message-ID: <20170314071231.GI3618@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 10:03:48PM +0100, Alexander Kurz wrote:
> According to the reference manuals, both imx50/imx53 SOC seem to share
> the same eSDHC controller, especially the section on "Multi-block Read"
> mentioned in commit 361b8482026c ("mmc: sdhci-esdhc-imx: fix multiblock
> reads on i.MX53") is identical for both SOC.
> Hence, let imx50 use imx53-esdhc.
> 
> Signed-off-by: Alexander Kurz <akurz@blala.de>

Applied, thanks.
