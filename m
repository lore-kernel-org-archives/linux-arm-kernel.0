From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Sat, 16 Apr 2016 20:40:44 -0400
Subject: [PATCH] i2c: exynos5: Fix possible ABBA deadlock by keeping I2C
 clock prepared
In-Reply-To: <CANAwSgSgjpqhnXmfpVdOPDDN+=36n_sbR+hVJGouBoKMahYGwA@mail.gmail.com>
References: <1460757887-18128-1-git-send-email-javier@osg.samsung.com>
 <CANAwSgSgjpqhnXmfpVdOPDDN+=36n_sbR+hVJGouBoKMahYGwA@mail.gmail.com>
Message-ID: <5712DB8C.70505@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Anand,

On 04/16/2016 08:15 AM, Anand Moon wrote:

[snip]

>>
> 
> Thanks for fixing this bug. I also tried the same thing on clk, but
> missed the return on failed.
> 
> Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
>

Thanks a lot for your testing and review.
 
> Best Regards
> -Anand Moon
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
