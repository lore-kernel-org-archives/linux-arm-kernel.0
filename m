From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 14 Sep 2011 20:56:12 +0530
Subject: [PATCH 0/6] zImage improvements with DTB append and ATAG
	compatibility
In-Reply-To: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
Message-ID: <CAJuYYwS0Ny3hUSC_sO9OJ34r8_ssZ0hFY4NL6jt+1i-Tbr95Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 September 2011 11:11, Nicolas Pitre <nico@fluxnic.net> wrote:
> This is the latest incarnation of my patch series allowing a DTB
> to be appended to zImage, including the ATAG conversion wrapper and
> other minor cleanups.
>
> This can also be pulled from:
>
> ? ? ? ?git://git.linaro.org/people/nico/linux zImage_DTB_append
>
> This works for me on the test setup I have.
> ACKs/Tested-By's would be appreciated.


Works fine for Exynos4 device tree support.

Tested-by: Thomas Abraham <thomas.abraham@linaro.org>

>
>
>
>
> Nicolas
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
