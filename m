From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 31 Aug 2012 11:02:54 +0530
Subject: [PATCH RESEND 0/6] ARM: EXYNOS: Add support for Trats board using
 device tree
In-Reply-To: <1346311903-15920-1-git-send-email-t.figa@samsung.com>
References: <1346311903-15920-1-git-send-email-t.figa@samsung.com>
Message-ID: <CAJuYYwSUCNdfMXbMVVULPgTVC=zh=4qQR1YiA29JXvUCj6meGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 August 2012 13:01, Tomasz Figa <t.figa@samsung.com> wrote:
> This patch series adds basic device tree support for Samsung Trats board
> along with any necessary prerequisites.
>
> In addition it refactors Exynos4 dts include files to split parts common to
> the whole Exynos4 part from parts specific to Exynos4210 to allow further
> extension of Exynos4210 dts include file and addition of include files for
> other SoCs from Exynos4 line.
>
> Dependencies:
> -> [PATCH v5] mmc: sdhci-s3c: Add device tree support
> http://www.spinics.net/lists/linux-samsung-soc/msg12056.html
> -> [PATCH v5 2/2] regulator: add device tree support for max8997
> http://www.spinics.net/lists/kernel/msg1328117.html

I will follow up on this patch and resubmit it.

Thanks,
Thomas.

[...]
