From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 17:43:26 -0800
Subject: [GIT PULL] STM32 DT changes for v4.10 #1
In-Reply-To: <3e65d3ae-6509-6057-64e1-dfc256e535b5@st.com>
References: <3e65d3ae-6509-6057-64e1-dfc256e535b5@st.com>
Message-ID: <20161118014326.GJ8578@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 04, 2016 at 03:31:55PM +0100, Alexandre Torgue wrote:
> Hi Olof, Arnd and Kevin,
> 
> Please consider this first round of STM32 DT updates for v4.10:
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git
> tags/stm32-dt-for-v4.10-1
> 
> for you to fetch changes up to f6dbbff4f0af1a5c0d6eaf414572b5eff7a73a8b:
> 
>   ARM: dts: stm32f429: add LSI and LSE clocks (2016-11-04 15:08:08 +0100)
> 
> ----------------------------------------------------------------
> STM32 DT updates for v4.10, round 1.
> 
> Highlights:
> ----------
>  - Add LSI and LSE clocks support for STM32F429
>  - Add GPIO IRQ support for STM32F429
>  - Declare push button as GPIO keys on STM32F429 boards
>  - Add DMA supports on USART1 & USART3 on STM32F429
>  - Add Ethernet fixes
> 
> ----------------------------------------------------------------
> Alexandre TORGUE (5):
>       ARM: DT: STM32: add dma for usart3 on F429
>       ARM: DT: stm32: move dma translation to board files
>       ARM: dts: stm32f429: Align Ethernet node with new bindings properties
>       ARM: dts: stm32f429: Fix Ethernet node on Eval Board
>       ARM: dts: stm32f429: remove Ethernet wake on Lan support
> 
> Gabriel Fernandez (1):
>       ARM: dts: stm32f429: add LSI and LSE clocks
> 
> Gerald Baeza (1):
>       ARM: DT: STM32: add dma for usart1 on F429
> 
> Maxime Coquelin (2):
>       ARM: dts: Add GPIO irq support to STM32F429
>       ARM: dts: Declare push button as GPIO key on stm32f429 boards

I merged this but please get your contributors to use consistent prefixes
in the future (or fix them up when you apply the patchest).

It should be: ARM: dts: stm32: <...> in your case.


Thanks!

-Olof
