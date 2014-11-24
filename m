From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 24 Nov 2014 14:31:53 +0530
Subject: [PATCH v4 1/2] i2c: s3c2410: Handle i2c sys_cfg register in i2c
 driver
In-Reply-To: <019101d005ed$fd3d5eb0$f7b81c10$@kernel.org>
References: <1414656270-8048-1-git-send-email-pankaj.dubey@samsung.com>
 <1414656270-8048-2-git-send-email-pankaj.dubey@samsung.com>
 <20141121072545.GG1480@katana> <546F1140.4050709@samsung.com>
 <20141121164726.GA1426@katana> <019101d005ed$fd3d5eb0$f7b81c10$@kernel.org>
Message-ID: <5472F401.30404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 22 November 2014 06:18 AM, Kukjin Kim wrote:
> Wolfram Sang wrote:
>>
> Hi Wolfram,
>
>>>> I usually don't take DTS patches. They should go via arm-soc. Please say
>>>> so if there are reasons I should take them.
>>>
>>> I CC'ed to you because same patch contains changes in i2c driver.
>>
>> Yes, those should absolutely go via my I2C tree. You need to make a
>> seperate patch out of the dts changes which then also should go via
>> samsung-soc, unless Kukjin says he really wants to go the via I2C. But I
>> guess the latter will just create merge conflicts.
>
> Hmm...I think, Pankaj needs to submit separated patches 1) driver change, 2) dt
> change and then 3) remove change. And 2nd and 3rd changes should be handed in
> Samsung tree together after landing 1) change in -next.
>
> Of course, 1) change should be handled in i2c tree ;)
>

Thanks for review and guidance. I separated i2c driver changes and 
posted it as v6 here [1]. DT changes and mach-exynos removal of i2c 
settings have been posted as v6 here [2]. Please do review and if OK 
let's get it merged.

[1]: i2c-driver: https://patchwork.kernel.org/patch/5363981/
[2]: mach-exynos: 
http://comments.gmane.org/gmane.linux.kernel.samsung-soc/40155

Thanks,
Pankaj Dubey
> Thanks,
> Kukjin
>
>
