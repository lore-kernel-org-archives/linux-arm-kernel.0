From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 05 Jan 2015 14:22:19 +0100
Subject: [PATCH RESEND] ARM: exynos_defconfig: Enable options for display
 panel support
In-Reply-To: <047c01d028e7$311858e0$93490aa0$@kernel.org>
References: <1420215089-2093-1-git-send-email-javier.martinez@collabora.co.uk>
 <047c01d028e7$311858e0$93490aa0$@kernel.org>
Message-ID: <54AA900B.4000403@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

>> 
>> Hello Kukjin,
>> 
> Hi Javier,
> 
> Happy new year :)
>

Thanks, happy new year for you as well!

>> You dropped this patch since exynos drm was causing boot hangs on some
>> platforms but the fix for that issue is already in linux-next (commit:
>> f1e9203 clk: samsung: Fix Exynos 5420 pinctrl setup and clock disable
>> failure due to domain being gated) so I think it makes sense to enable
>> the display options again.
>> 
>> NOTE: Display panel is still not working since patch "arm: dts: Exynos5:
>> Use pmu_system_controller phandle for dp phy" is needed [0] but I think
>> we should enable display options to catch the regressions easier.
>> 
> Agreed with your suggestion and I'll pick this up into Samsung tree soon.
> 

Perfect, I hope you can pick my peach pit/pi and snow DTS updates series
as well since those patches have been in the list for some time.

> Thanks,
> Kukjin
> 

Best regards,
Javier
