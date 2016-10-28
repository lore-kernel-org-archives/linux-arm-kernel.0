From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 28 Oct 2016 10:49:14 -0300
Subject: [PATCH 1/2] ARM: dts: exynos: Use macro for PWM signal polarity
 in Exynos4 boards
In-Reply-To: <20161028134138.GB5646@kozik-lap>
References: <1477590438-18095-1-git-send-email-javier@osg.samsung.com>
 <20161028134138.GB5646@kozik-lap>
Message-ID: <31a8217c-969e-63a4-167c-9027ab1d8581@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/28/2016 10:41 AM, Krzysztof Kozlowski wrote:
> On Thu, Oct 27, 2016 at 02:47:17PM -0300, Javier Martinez Canillas wrote:
>> Using the PWM_POLARITY_INVERTED macro instead of the hardcoded number
>> 0 makes the DTS easier to read.
> 
> 
> Eeee.... PWM_POLARITY_INVERTED = 1 << 0 = 1.
> 
> And you are replacing 0 with 1. Hm? This is not described at all in
> commit message...
> 
> Best regards,
> Krzysztof
> 

Damn! I don't know how I misread the DTS macro as 0, and didn't find issues
when testing the patches on an Exynos5800 Peach Pi.

I should had run scripts/dtc/dtx_diff to notice that the DTB changed, I'm
so sorry about that...

Please discard the patches.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
