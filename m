From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 13 Jan 2017 01:38:40 +0100
Subject: [PATCHv5 3/8] rtc: add STM32 RTC driver
In-Reply-To: <1484142403-11556-1-git-send-email-amelie.delaunay@st.com>
References: <1484142403-11556-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <20170113003840.u6uxt7u4qsit3oqt@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/2017 at 14:46:43 +0100, Amelie Delaunay wrote :
> This patch adds support for the STM32 RTC.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  drivers/rtc/Kconfig     |  11 +
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-stm32.c | 727 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 739 insertions(+)
>  create mode 100644 drivers/rtc/rtc-stm32.c
> 

This didn't apply cleanly, please check rtc-next. I don't think I made
any mistake as the issue was only in Kconfig. You probably based your
patches on 4.9 instead of 4.10-rc1.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
