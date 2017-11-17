From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 17 Nov 2017 20:56:42 +0800
Subject: [PATCH resend] arm: dts: ls1021a: add "fsl, ls1021a-esdhc"
 compatible string to esdhc node
In-Reply-To: <1510834526-32730-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1510583976-6661-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1510834526-32730-1-git-send-email-rasmus.villemoes@prevas.dk>
Message-ID: <20171117125641.GD25390@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 01:15:26PM +0100, Rasmus Villemoes wrote:
> Commit a22950c888e3 (mmc: sdhci-of-esdhc: add quirk
> SDHCI_QUIRK_BROKEN_TIMEOUT_VAL for ls1021a) added logic to the driver to
> enable the broken timeout val quirk for ls1021a, but did not add the
> corresponding compatible string to the device tree, so it didn't really
> have any effect. Fix that.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Applied, thanks.
