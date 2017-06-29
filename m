From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 29 Jun 2017 17:09:21 +0200
Subject: [PATCH 00/20] Update STM32 usart driver
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Message-ID: <3eaff22e-4a7b-d491-4d84-aeccbd444d0d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg, Rob

On 06/26/2017 02:49 PM, Bich HEMON wrote:
> From: Bich Hemon <bich.hemon@st.com>
> 
> This patchset updates the stm32 usart driver. It mainly adds
> support for fifo, dma, debugfs anf fixes various bugs.
> 
> Bich Hemon (20):
>    serial: stm32: adding fifo support
>    dt-bindings: serial: each stm32 usart needs an alias
>    serial: stm32: fix multi ports management
>    serial: stm32: make fifoen as property for each port
>    serial: stm32: add debugfs
>    serial: stm32: fix pio transmit timeout
>    serial: stm32: less messages on dma alloc error
>    serial: stm32: timeout interrupt using with dma
>    serial: stm32: fix end of transfer
>    serial: stm32: fix dma receive
>    serial: stm32: add RTS support
>    serial: stm32: fix last_res value
>    serial: stm32: fix error handling in probe
>    dt-bindings: serial: document option wake-up interrupt for STM32 USART
>    serial: stm32: Add wakeup mechanism
>    serial: stm32: fix fifo usage
>    dt-bindings: serial: stm32: add dma using note
>    serial: stm32: update dma buffers length
>    serial: stm32: add dma rx callback
>    serial: stm32: fix rx interrupt handling in startup
> 
>   .../devicetree/bindings/serial/st,stm32-usart.txt  |  55 +++-
>   drivers/tty/serial/stm32-usart.c                   | 310 ++++++++++++++++++---
>   drivers/tty/serial/stm32-usart.h                   |  51 +++-
>   3 files changed, 375 insertions(+), 41 deletions(-)
> 

This series have been abandoned (maybe not in correct way). Don't waste 
your time with that. New patches will be sent in several series and 
patches will be reworked.

Thanks
Alex
