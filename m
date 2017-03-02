From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 2 Mar 2017 19:12:42 -0300
Subject: [PATCH v2] ARM: dts: imx50: imx50-esdhc use imx53-esdhc
In-Reply-To: <1488488628-11711-1-git-send-email-akurz@blala.de>
References: <1488488628-11711-1-git-send-email-akurz@blala.de>
Message-ID: <CAOMZO5CK=EijB651LC74Wn=hFAs10wmjxvaCGgGrQ8+XcaF1kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 2, 2017 at 6:03 PM, Alexander Kurz <akurz@blala.de> wrote:
> According to the reference manuals, both imx50/imx53 SOC seem to share
> the same eSDHC controller, especially the section on "Multi-block Read"
> mentioned in commit 361b8482026c ("mmc: sdhci-esdhc-imx: fix multiblock
> reads on i.MX53") is identical for both SOC.
> Hence, let imx50 use imx53-esdhc.
>
> Signed-off-by: Alexander Kurz <akurz@blala.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
