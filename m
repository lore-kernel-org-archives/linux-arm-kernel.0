From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 13 Jan 2015 13:30:27 +0100
Subject: [PATCH next 0/2] mmc: sdhci-pxav3: fix unbalanced pm and clock
 issues
In-Reply-To: <1420384548-7816-1-git-send-email-jszhang@marvell.com>
References: <1420384548-7816-1-git-send-email-jszhang@marvell.com>
Message-ID: <CAPDyKFpE-rgBB66R3iS_rQssa8z8LsTz=e6asi+8_EdUMfTBfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 January 2015 at 16:15, Jisheng Zhang <jszhang@marvell.com> wrote:
> These two patches fix unbalanced pm and clock issues. The clock unbalance
> issue would cause power consumption regression because the clock will never
> be gated at runtime PM suspend.
>
> Jisheng Zhang (2):
>   mmc: sdhci-pxav3: fix unbalanced clock issues during probe
>   mmc: sdhci-pxav3: fix pm unbalanced issue in -> remove()
>
>  drivers/mmc/host/sdhci-pxav3.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> --
> 2.1.4
>

Thanks! Applied for next.

Kind regards
Uffe
