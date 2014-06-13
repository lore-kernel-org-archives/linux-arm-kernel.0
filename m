From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 16:52:03 +0200
Subject: [PATCH 1/1] ARM: EXYNOS: Fix compilation warning
In-Reply-To: <537D6F12.7000201@linaro.org>
References: <1399282008-9738-1-git-send-email-sachin.kamat@linaro.org>
 <CAK9yfHyFEb3hchLLndfqW1xOHD59d_bsFMA4k5MLJ8Hgpx7Ekw@mail.gmail.com>
 <537D6F12.7000201@linaro.org>
Message-ID: <201406131652.03461.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 May 2014, Tushar Behera wrote:
> On 05/21/2014 04:56 PM, Sachin Kamat wrote:
> > On 5 May 2014 14:56, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> >> of_get_flat_dt_prop return type is now const.
> >> Fixes the following compilation warning introduced by commit 9d0c4dfedd96
> >> ("of/fdt: update of_get_flat_dt_prop in prep for libfdt")
> >>
> >> arch/arm/mach-exynos/exynos.c:259:6: warning:
> >> assignment discards ?const? qualifier from pointer target type [enabled by default]
> >>
> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> Cc: Rob Herring <robh@kernel.org>
> >> ---
> 
> Change looks good.
> 
> Reviewed-by: Tushar Behera <tushar.behera@linaro.org>

This hasn't shown up in linux-next yet, and hte bug is still there, so I'm applying
it directly to the fixes branch in arm-soc before we get more people sending
the same patch. Thanks!

	Arnd
