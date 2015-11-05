From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 05 Nov 2015 17:07:41 +0900
Subject: [PATCH v5 0/4] Exynos SROMc configuration and Ethernet support for
 SMDK5410
In-Reply-To: <000b01d1179f$ed5032b0$c7f09810$@samsung.com>
References: <cover.1446542020.git.p.fedin@samsung.com>
 <5639B588.1080901@samsung.com> <000b01d1179f$ed5032b0$c7f09810$@samsung.com>
Message-ID: <563B0E4D.6020808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2015 16:59, Pavel Fedin wrote:
>  Hello!
> 
>>> This patchset also depends on Exynos 5410 pinctrl support, introduced by
>>> patches 0003 and 0004 from this set:
>>> [PATCH v4 0/5] ARM: EXYNOS: ODROID-XU DT and LEDs
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/330862.html
>>
>> Only the first patch made up to kernel. The rest (2-5) received feedback
>> and I am waiting for fixing it. Andreas apparently loose the interest...
> 
>  I have rechecked the original thread on archives and found nothing new. Where can
> i read those feedbacks? Perhaps it makes sense for me to pick them up and include
> into my set.

Go ahead. The only waiting feedback is at patch 2/5:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/330910.html
Javier's pointed use of linux,stdout-path and putting xxti in
exynos5410.dtsi (and customizing it per board if needed).

Patches already got reviews and acks so only 2/5 is the stopper.

Best regards,
Krzysztof
