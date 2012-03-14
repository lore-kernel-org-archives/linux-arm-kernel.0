From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Mar 2012 01:25:11 -0700
Subject: [PATCH v2 3/3] gpio/samsung: use ioremap() for EXYNOS4 GPIOlib
In-Reply-To: <4F5E45E0.9020108@samsung.com>
References: <1329341829-14403-1-git-send-email-kgene.kim@samsung.com>
 <1329341829-14403-4-git-send-email-kgene.kim@samsung.com>
 <20120312161904.E57193E07B0@localhost> <4F5E45E0.9020108@samsung.com>
Message-ID: <4F6055E7.7040609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/12 11:52, Kukjin Kim wrote:
> Grant Likely wrote:
>> On Thu, 16 Feb 2012 06:37:09 +0900, Kukjin Kim<kgene.kim@samsung.com>   wrote:
>>> From: Sangsu Park<sangsu4u.park@samsung.com>
>>>
>>> This patch changes to use ioremap() for EXYNOS4210
>>> so that we can drop the static mapping for EXYNOS
>>> SoCs.
>>>
>>> Note: Will be updated for all of Samsung GPIOlibs
>>> to use ioremap() next time.
>>>
>>> Signed-off-by: Sangsu Park<sangsu4u.park@samsung.com>
>>> Cc: Grant Likely<grant.likely@secretlab.ca>
>>> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
>>
>> Acked-by: Grant Likely<grant.likely@secretlab.ca>
>>
>> Kukjin, I think you wanted to take this via your tree?  I'm fine with that.
>> Let me know if you'd rather it go via the gpio tree.
>>
> Hi Grant,
> 
> I think, since this series has no depenency with current samsung tree
> for upcoming merge window, this can be sent to upstream via the gpio tree.
> 
Grant,

If you don't pick this up for your tree yet, let me take this series in
samsung tree.
This patches are needed for samsung tree. Sorry for bothering and if any
problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
