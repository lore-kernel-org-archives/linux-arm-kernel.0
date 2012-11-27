From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Nov 2012 08:31:30 +0900
Subject: [PATCH] ARM: Exynos: Remove unused non-dt support for dwmci
 controller
In-Reply-To: <CAJuYYwT+p3PdALE8uHQ9hszbYBxnjg-joZZtU3_gmDfjG4FL=g@mail.gmail.com>
References: <1353914155-1716-1-git-send-email-thomas.abraham@linaro.org>	<001301cdcc5c$3e87b0f0$bb9712d0$%jun@samsung.com>
 <CAJuYYwT+p3PdALE8uHQ9hszbYBxnjg-joZZtU3_gmDfjG4FL=g@mail.gmail.com>
Message-ID: <50B54D52.8070209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/12 17:50, Thomas Abraham wrote:
> On 27 November 2012 10:31, Seungwon Jeon<tgih.jun@samsung.com>  wrote:
>> On Monday, November 26, 2012, Thomas Abraham<thomas.abraham@linaro.org>  wrote:
>>> With device tree support enabled for dwmci controller, the unused non-dt support
>>> for dwmci controller can be removed.
>>>
>>> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
>>> ---
>>>   arch/arm/mach-exynos/Makefile             |    1 -
>>>   arch/arm/mach-exynos/dev-dwmci.c          |   75 -----------------------------
>>>   arch/arm/mach-exynos/include/mach/dwmci.h |   20 --------
>>>   3 files changed, 0 insertions(+), 96 deletions(-)
>>>   delete mode 100644 arch/arm/mach-exynos/dev-dwmci.c
>>>   delete mode 100644 arch/arm/mach-exynos/include/mach/dwmci.h
>>
>> Hi Thomas,
>>
>> The following parts are remained. Also, no used code.
>> Could you check it?
>>
>> ./plat-samsung/include/plat/devs.h:126:extern struct platform_device exynos4_device_dwmci;
>> ./Kconfig:111:config EXYNOS4_DEV_DWMCI
>
> Hi Seungwon,
>
> Yes, I have missed that. Thanks for pointing this out. I will take care of this.
>
I amended the commit as per Seungwon's pointing out.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
