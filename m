From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 18 Apr 2018 17:23:25 +0200
Subject: [PATCH] [media] include/media: fix missing | operator when
 setting cfg
In-Reply-To: <ebce8e36-9125-aecb-b0d1-87f068646e67@samsung.com>
References: <CGME20180418150622epcas4p4be934b89937c0e50a2f236116c02d7cb@epcas4p4.samsung.com>
 <20180418150617.22489-1-colin.king@canonical.com>
 <ebce8e36-9125-aecb-b0d1-87f068646e67@samsung.com>
Message-ID: <bafbcf6c-a08d-11ba-af25-655b7cc44e1c@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2018 05:20 PM, Sylwester Nawrocki wrote:
> On 04/18/2018 05:06 PM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The value from a readl is being masked with ITE_REG_CIOCAN_MASK however
>> this is not being used and cfg is being re-assigned.  I believe the
>> assignment operator should actually be instead the |= operator.
>>
>> Detected by CoverityScan, CID#1467987 ("Unused value")
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Thanks for the patch.
> 
> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

I forgot to mention that the subject should rather looks something
like:

"exynos4-is: fimc-lite: : fix missing | operator when setting cfg"

-- 
Regards,
Sylwester
