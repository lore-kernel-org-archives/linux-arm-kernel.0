From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 13 Nov 2017 13:16:31 -0200
Subject: [PATCH] arm: dts: ls1021a: add "fsl, ls1021a-esdhc" compatible
 string to esdhc node
In-Reply-To: <1510583976-6661-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1510583976-6661-1-git-send-email-rasmus.villemoes@prevas.dk>
Message-ID: <CAOMZO5Di8UsXvgFnKtibrpbMG9b7uiDa2gdGPPNHE+CV52D9AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 13, 2017 at 12:39 PM, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
> Commit a22950c888e3 (mmc: sdhci-of-esdhc: add quirk
> SDHCI_QUIRK_BROKEN_TIMEOUT_VAL for ls1021a) added logic to the driver to
> enable the broken timeout val quirk for ls1021a, but did not add the
> corresponding compatible string to the device tree, so it didn't really
> have any effect. Fix that.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
