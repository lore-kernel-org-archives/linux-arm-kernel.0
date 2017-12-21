From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 16:11:33 +0100
Subject: [PATCH] ARM: make ARCH_S3C24XX select USE_OF and clean-up
 boot/dts/Makefile
In-Reply-To: <1511749163-11057-1-git-send-email-yamada.masahiro@socionext.com>
References: <1511749163-11057-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK8P3a1Z+Y_iz4KAKYXAfoRBpT+1q--6SsatRtCfZdyiR+7_Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 3:19 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> ARCH_S3C24XX is a very exceptional platform that some DT files in
> arch/arm/boot/dts/, but does not select USE_OF.
>
> All the other platforms with DT files correctly select USE_OF
> directly or indirectly (Most of them are either ARCH_MULTIPLATFORM
> or ARM_SINGLE_ARMV7M).
>
> With ARCH_S3C24XX fixed, "ifeq ($(CONFIG_OF),y)" in DT Makefile
> can be deleted.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to next/dt, thanks!

        Arnd
