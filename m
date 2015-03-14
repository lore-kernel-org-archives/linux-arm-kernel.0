From: bgamari.foss@gmail.com (Ben Gamari)
Date: Sat, 14 Mar 2015 15:13:29 -0400
Subject: [RFC 0/5] ARM: EXYNOS: ODROID-XU DT and LEDs
In-Reply-To: <53D9CA35.1030800@suse.de>
References: <1406549892-5558-1-git-send-email-afaerber@suse.de>
 <53D9CA35.1030800@suse.de>
Message-ID: <87oanv9yue.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber <afaerber@suse.de> writes:

> Kukjin,
>
> Am 28.07.2014 14:18, schrieb Andreas F?rber:
>> Hello,
>> 
>> This series adds a dedicated ODROID-XU device tree and enhances it with 
>> LED configuration, to match the downstream 3.14 based behavior.
>> 
>> It had turned out less trivial than I initially thought as the whole 
>> pinctrl stuff is still missing. I thus cherry-pick two downstream commits.
>> 
>> Hakjoo, can you please reply with a Signed-off-by to your patches
>> so that we can get them into upstream? Thanks in advance!
>
> FTR, Hakjoo Kim did reply with signed off patches (thanks again!) and
> updated their branch accordingly:
>
> https://github.com/hardkernel/linux/commits/odroid-3.14.y-linaro
> https://github.com/hardkernel/linux/commit/53edc3da0d1da287517681b47daf36679637b6ba
> https://github.com/hardkernel/linux/commit/afdc310e47e4d1799719566bfb5a47c55141a7cb
>
>> Andreas F?rber (3):
>>   ARM: dts: exynos5410: Clean up SMDK5410 indentation
>>   ARM: dts: exynos5410: Prepare ODROID-XU device tree
>
> The functional changes below haven't been reviewed yet, but could you
> consider applying trivial patches 1-2?
>
> Regards,
> Andreas
>
>>   ARM: dts: exynos5410: Add ODROID-XU LEDs
>> 
>> Hakjoo Kim (2):
>>   pinctrl: exynos: add exynos5410 SoC specific data
>>   ARM: dts: add pinctrl support to Exynos5410
>> 

What happened with this set? It appears that 1-2 were never merged nor
was there any review of the remaining patches.

Cheers,

- Ben
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 472 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150314/2eab00f4/attachment.sig>
