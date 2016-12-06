From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 6 Dec 2016 12:57:25 +0000
Subject: [PATCH v4 7/7] ARM: dts: stm32: add STM32 General Purpose Timer
 driver in DT
In-Reply-To: <1481027929-13704-8-git-send-email-benjamin.gaignard@st.com>
References: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
 <1481027929-13704-8-git-send-email-benjamin.gaignard@st.com>
Message-ID: <20161206125725.GG25385@dell.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Dec 2016, Benjamin Gaignard wrote:

> Add General Purpose Timers and it sub-nodes into DT for stm32f4.
> Define and enable pwm1 and pwm3 for stm32f469 discovery board
> 
> version 4:
> - remove unwanted indexing in pwm@ and timer@ node name
> - use "reg" instead of additional parameters to set timer
>   configuration
> 
> version 3:
> - use "st,stm32-timer-trigger" in DT
> 
> version 2:
> - use parameters to describe hardware capabilities
> - do not use references for pwm and iio timer subnodes
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  arch/arm/boot/dts/stm32f429.dtsi      | 276 +++++++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/stm32f469-disco.dts |  28 ++++
>  2 files changed, 303 insertions(+), 1 deletion(-)

This now looks really neat.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
