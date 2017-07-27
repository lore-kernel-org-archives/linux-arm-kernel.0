From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Jul 2017 12:57:50 +0200
Subject: [PATCH resend v2] soc: zte: Restrict SOC_ZTE to ARCH_ZX or
 COMPILE_TEST
In-Reply-To: <1500966738-4431-1-git-send-email-geert@linux-m68k.org>
References: <1500966738-4431-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAK8P3a1h7K3ecCcbMQ=egp5_dZ13ACcRgJoeFgmRsQityUn2tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 9:12 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> The ZTE SoC drivers are only useful when building for a ZTE ZX platform.
>
> Fixes: 4c2c2e39713b8cfb ("soc: zte: pm_domains: Prepare for supporting ARMv8 zx2967 family")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
> Sent before on 2017-05-29.

Applied to fixes, thanks

      Arnd
