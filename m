From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 5 Jun 2014 16:26:20 +0100
Subject: [STLinux Kernel] [PATCH 4/6] thermal: sti: Add support for ST's
 Memory Mapped based Thermal controller
In-Reply-To: <1401442715-6350-5-git-send-email-lee.jones@linaro.org>
References: <1401442715-6350-1-git-send-email-lee.jones@linaro.org>
 <1401442715-6350-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20140605152620.GD7446@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 30 May 2014, Lee Jones wrote:

> This is the traditional way of obtaining a device driver's register
> address space.  The aim of this driver is to supply controller specific
> information to the ST Thermal Core.
> 
> Signed-off-by: Ajit Pal Singh <ajitpal.singh@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/thermal/st/Kconfig             |   4 +
>  drivers/thermal/st/Makefile            |   1 +
>  drivers/thermal/st/st_thermal_memmap.c | 209 +++++++++++++++++++++++++++++++++
>  3 files changed, 214 insertions(+)
>  create mode 100644 drivers/thermal/st/st_thermal_memmap.c

For the rest of the series [4 to 6]: 
 Acked-by: Peter Griffin <peter.griffin@linaro.org>> 

regards,

Peter.
