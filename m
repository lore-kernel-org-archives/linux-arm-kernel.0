From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 05 Jan 2015 10:09:48 +0100
Subject: [PATCH RESEND] ARM: exynos_defconfig: Enable options for display
 panel support
In-Reply-To: <1420447691.3918.2.camel@AMDC1943>
References: <1420215089-2093-1-git-send-email-javier.martinez@collabora.co.uk>
 <1420447691.3918.2.camel@AMDC1943>
Message-ID: <54AA54DC.6000407@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

>> Hello Kukjin,
>> 
>> You dropped this patch since exynos drm was causing boot hangs on some
>> platforms but the fix for that issue is already in linux-next (commit:
>> f1e9203 clk: samsung: Fix Exynos 5420 pinctrl setup and clock disable
>> failure due to domain being gated) so I think it makes sense to enable
>> the display options again.
> 
> I think these issues were unrelated to each other. DRM was disabled
> because of infinite deferred probing of DRM components. I saw Inki was
> sending some patches for it but I am not sure if they were merged.
>

Ups, you are completely right and it was my bad for pasting the wrong
commit fixing the boot hang when DRM was enabled, I actually meant commit:
("820687be drm/exynos: move Exynos platform drivers registration to init")
which also landed in v3.19-rc1.

Sorry for the confusion.
 
> Best regards,
> Krzysztof

Best regards,
Javier
