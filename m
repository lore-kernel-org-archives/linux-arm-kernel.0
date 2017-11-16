From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 16 Nov 2017 09:53:41 -0200
Subject: [PATCH] arm: dts: ls1021a: add "fsl, ls1021a-esdhc" compatible
 string to esdhc node
In-Reply-To: <1510583976-6661-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1510583976-6661-1-git-send-email-rasmus.villemoes@prevas.dk>
Message-ID: <CAOMZO5AJzzTNHP2J1ej8Kk=2ow0yQK264Cmho2D99WqRXiDm=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rasmus,

On Mon, Nov 13, 2017 at 12:39 PM, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
> Commit a22950c888e3 (mmc: sdhci-of-esdhc: add quirk
> SDHCI_QUIRK_BROKEN_TIMEOUT_VAL for ls1021a) added logic to the driver to
> enable the broken timeout val quirk for ls1021a, but did not add the
> corresponding compatible string to the device tree, so it didn't really
> have any effect. Fix that.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Please resend it with Shawn Guo on Cc. Thanks
