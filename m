From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 6 Jul 2017 22:53:38 +0200
Subject: [PATCHv2 0/2] rtc: add support for STM32H7 RTC
In-Reply-To: <1499330865-17232-1-git-send-email-amelie.delaunay@st.com>
References: <1499330865-17232-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <20170706205338.oke7vnr7nh5s6ykq@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2017 at 10:47:43 +0200, Amelie Delaunay wrote:
> Add support for STM32H7 Real Time Clock variant.
> Difference is regarding clocks: there is a 'pclk' clock on STM32H7
> for register access.
> 
> Amelie Delaunay (2):
>   dt-bindings: rtc: stm32: add support for STM32H7
>   rtc: stm32: add STM32H7 RTC support
> 
>  .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 32 +++++++--
>  drivers/rtc/rtc-stm32.c                            | 82 +++++++++++++++++-----
>  2 files changed, 92 insertions(+), 22 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
