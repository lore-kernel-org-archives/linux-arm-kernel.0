From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 27 Mar 2014 14:42:42 -0700
Subject: [PATCH] ARM: sunxi: Select HAVE_ARM_ARCH_TIMER
In-Reply-To: <1395934061-5340-1-git-send-email-maxime.ripard@free-electrons.com>
 (Maxime Ripard's message of "Thu, 27 Mar 2014 16:27:41 +0100")
References: <1395934061-5340-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <7hy4zv71yl.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@free-electrons.com> writes:

> In order for the architected timers support to be enabled in the kernel, this
> option has to be enabled. Otherwise, the architected timers driver won't be
> compiled in, and we will not get to use them.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>
> Hi Arnd, Kevin, Olof,
>
> It would be great if you could apply this patch directly on top of the current
> arm-soc for-next.

Applied to next/soc, merged into for-next.

With this, merging Emilio's clk pull req in as a dependenency and
upgrading u-boot on my Cubie2 for the proper architected timer init, it
seems all the boot regressions on sunxi have disappeared.

Thanks,

Kevin
