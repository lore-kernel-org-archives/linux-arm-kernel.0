From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 07 Apr 2015 16:26:29 +0200
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is
 enabled during suspend
In-Reply-To: <CAM4voanig_BQrEKGA0YYX_80Gvbtmau3zwz7mQUKtvNMCO-LuQ@mail.gmail.com>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>	<1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>	<CA+Ln22FBpuzR06qCsVc7SXtLX2mhf901vDE5D-mT1+ijZ2G3sg@mail.gmail.com>	<551976F1.1000605@collabora.co.uk>	<CAM4voanL3A=dS8Z-ovi_-EDi9ctyaxZkvjajp+3ZjyNAnqR1aQ@mail.gmail.com>	<551AFCCE.4050404@collabora.co.uk>	<551BD07E.2090506@samsung.com>	<551BDA0A.7010704@collabora.co.uk>	<551C2B6D.4010001@samsung.com>	<551C71A5.1070903@collabora.co.uk>	<CAM4voakS8PnatqRTW5gkD0NNKD9gW9Tuv5p-ekxFhKN5NcuBCQ@mail.gmail.com>	<5523B878.8040304@collabora.co.uk>
 <CAM4voanig_BQrEKGA0YYX_80Gvbtmau3zwz7mQUKtvNMCO-LuQ@mail.gmail.com>
Message-ID: <5523E915.5070203@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Abhilash,

On 04/07/2015 04:11 PM, Abhilash Kesavan wrote:
> 
> Yes, though it increasingly looks like aclk266_g2d needs to stay ON
> and we should use your patch that keeps it enabled prior to suspend.
>

Indeed, could you please give me some feedback on the latest RFC patch
I shared [0] on this thread according to Tomasz comments?
 
> Regards,
> Abhilash
>>

Thanks a lot and best regards,
Javier

[0]: https://lkml.org/lkml/2015/4/7/537
