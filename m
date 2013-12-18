From: agust@denx.de (Anatolij Gustschin)
Date: Wed, 18 Dec 2013 20:53:15 +0100
Subject: [PATCH v1 0/4] powerpc/512x: update COMMON_CLK support for MPC5125
In-Reply-To: <1386681097-14126-1-git-send-email-gsi@denx.de>
References: <1386681097-14126-1-git-send-email-gsi@denx.de>
Message-ID: <20131218205315.2431b5db@crub>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Dec 2013 14:11:33 +0100
Gerhard Sittig <gsi@denx.de> wrote:
...
> Gerhard Sittig (4):
>   powerpc/512x: clk: minor comment updates
>   powerpc/512x: clk: enforce even SDHC divider values
>   powerpc/512x: clk: support MPC5121/5123/5125 SoC variants
>   powerpc/512x: dts: add MPC5125 clock specs
> 
>  arch/powerpc/boot/dts/mpc5125twr.dts          |   53 +++-
>  arch/powerpc/include/asm/mpc5121.h            |    7 +-
>  arch/powerpc/platforms/512x/clock-commonclk.c |  369 +++++++++++++++++++++----
>  include/dt-bindings/clock/mpc512x-clock.h     |    9 +-
>  4 files changed, 386 insertions(+), 52 deletions(-)

Applied this series to mpc5xxx next. Thanks!

Anatolij
