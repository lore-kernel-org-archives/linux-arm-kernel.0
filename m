From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 04 Nov 2011 22:17:42 +0900
Subject: arm-soc samsung patches blocked on dmaengine patches
In-Reply-To: <438BB0150E931F4B9CE701519A446301087AA53D66@bgsmsx502.gar.corp.intel.com>
References: <201111041400.44486.arnd@arndb.de>
	<438BB0150E931F4B9CE701519A446301087AA53D66@bgsmsx502.gar.corp.intel.com>
Message-ID: <4EB3E5F6.7060705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/11 22:06, Koul, Vinod wrote:
>> Hi Vinod and Kukjin,
>>
>> Right now, all the patches from the arm-soc tree are merged into 3.2, but the
>> samsung/cleanup and samsung/devel series are missing because they depend on
>> patches in the dmaengine tree. I'm not sure about the status of that tree,
>> but I didn't see a pull request for them yet.
>>
>> Should I just submit the samsung tree with the dmaengine patches included,
>> or keep waiting?
>>
> Arnd,
>
> I have already sent pull request to Linus on Monday[1], still waiting for
> these to get merged
>
Arnd,

So I think you can send them to Linus.

And as a note, I sent next-samsung-devel-4 which includes supporting 
EXYNOS4 DT and reorganization mach-exynos and something to you. I hope 
you can pick them up with others too. If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
