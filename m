From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Mar 2012 05:12:40 -0800
Subject: [PATCH v2 04/11] ARM: EXYNOS: add interrupt definitions for
 EXYNOS5250
In-Reply-To: <CAOesGMgedngJKRVCYwK=+xRnchXj4StGLTVqvv9BMqVhtM=5RA@mail.gmail.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>	<1328981685-8602-5-git-send-email-kgene.kim@samsung.com>	<CAOesGMhmcnt6LPb9O+3420VgG=PiCnOjzZA3JqsA=4OdHN-R-g@mail.gmail.com>	<00a901ccf084$90460900$b0d21b00$%kim@samsung.com>
 <CAOesGMgedngJKRVCYwK=+xRnchXj4StGLTVqvv9BMqVhtM=5RA@mail.gmail.com>
Message-ID: <4F575EC8.2090205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/12 10:55, Olof Johansson wrote:
> Hi,
>
> On Tue, Feb 21, 2012 at 2:35 AM, Kukjin Kim<kgene.kim@samsung.com>  wrote:
>
>> Yes, as you said, it brakes single zImage for EXYNOS4 + EXYNOS5
>> (mach-exynos). So I'm working on regarding resource for EXYNOS SoCs and I
>> think, it can resolve the problem you said before v3.4 merge window.
>>
>> If any updates, let you know.
>
> Just a friendly reminder; the time is close to running out for staging
> new code for 3.4.
>
Hi Olof,

Thanks for your kindly reminder but I couldn't finish it yet because it 
is required to touch most of samsung stuff, and it's a big change. 
Frankly, I need more time...

So how about sending current exynos5 stuff for now and then sorting out 
single kernel for exynos4 and exynos5 next time? Actually, this exynos5 
arch part is _really_ needed for developing/contribution of drivers on 
exynos5.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
