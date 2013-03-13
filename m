From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 13 Mar 2013 09:34:01 +0200
Subject: OMAP baseline test results for v3.9-rc1
In-Reply-To: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
Message-ID: <51402BE9.5040402@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/13 18:40, Paul Walmsley wrote:
> 
> Here are some basic OMAP test results for Linux v3.9-rc1.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.9-rc1/20130312100243/

[...]

> Failing tests: needing investigation
> ------------------------------------

[...]

> * CM-T3517: boot hangs with MMC root
>   - Due to missing MMC setup in board file
>   - http://www.spinics.net/lists/arm-kernel/msg211471.html
>   - Longstanding bug

This should have been fixed by:
ff95793 (ARM: OMAP3: cm-t3517: add MMC support)

I also can't find the MMC rootfs boot log on your website.


-- 
Regards,
Igor.
