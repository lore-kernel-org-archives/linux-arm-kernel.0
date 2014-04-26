From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 25 Apr 2014 18:21:04 -0700
Subject: [GIT PULL] at91: fixes for 3.15 #1
In-Reply-To: <1397857958-11283-1-git-send-email-nicolas.ferre@atmel.com>
References: <1397857958-11283-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <535B0A00.9080808@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/2014 14:52, Nicolas Ferre :
> Arnd, Olof, Kevin,
> 
> Two little fixes for AT91. The one that moves the dt-bindings include
> directory is pretty interesting as, with Exynos, AT91 was the only one
> to use this "clk" directory.
> 
> Thanks, best regards,
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-fixes

Arnd,

It seems that this material has not been integrated in today's arm-soc
pull-request to Linus.

Was it too late for this batch?

Bye,

> for you to fetch changes up to 35d35aae817706800a4913711d563a99e1dc380a:
> 
>   dt-bindings: clock: Move at91.h to dt-bindigs/clock (2014-04-18 23:44:52 +0200)
> 
> ----------------------------------------------------------------
> 3.15 fixes for AT91
> - one little DT fix
> - the use of proper directory for clock in include/dt-bindings
>   it allows to remove the now empty include/dt-bindings/clk
> 
> ----------------------------------------------------------------
> Bo Shen (1):
>       ARM: at91: fix spi cs on sama5d3 Xplained board
> 
> Tushar Behera (1):
>       dt-bindings: clock: Move at91.h to dt-bindigs/clock
> 
>  Documentation/devicetree/bindings/clock/at91-clock.txt | 2 +-
>  arch/arm/boot/dts/at91-sama5d3_xplained.dts            | 4 ++--
>  arch/arm/boot/dts/at91sam9261.dtsi                     | 2 +-
>  arch/arm/boot/dts/at91sam9rl.dtsi                      | 2 +-
>  arch/arm/boot/dts/sama5d3.dtsi                         | 2 +-
>  arch/arm/boot/dts/sama5d3_mci2.dtsi                    | 2 +-
>  arch/arm/boot/dts/sama5d3_tcb1.dtsi                    | 2 +-
>  arch/arm/boot/dts/sama5d3_uart.dtsi                    | 2 +-
>  include/dt-bindings/{clk => clock}/at91.h              | 0
>  9 files changed, 9 insertions(+), 9 deletions(-)
>  rename include/dt-bindings/{clk => clock}/at91.h (100%)
> 


-- 
Nicolas Ferre
