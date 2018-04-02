From: neil.m.leeder@gmail.com (Neil Leeder)
Date: Mon, 2 Apr 2018 13:59:47 -0400
Subject: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <66ef3bf4-9550-94c7-f8ad-ee53d6c75025@huawei.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-3-git-send-email-nleeder@codeaurora.org>
 <883d32ce-6581-ecf6-5088-ecb238322ebe@huawei.com>
 <e55ab4404143ea0b3cc4795a93e37480@codeaurora.org>
 <14f90cc6-f2c1-5a63-67c6-a5c8ddb4799e@gmail.com>
 <c1f9230b-8ff0-5b2e-def9-cbf6b2e2e99c@huawei.com>
 <66ef3bf4-9550-94c7-f8ad-ee53d6c75025@huawei.com>
Message-ID: <0094c5ab-89db-409f-d5fb-c961f9d84740@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On 4/2/2018 10:24 AM, Hanjun Guo wrote:
<SNIP>
> 
> I think we need to wait for the new version of IORT spec,
> which includes the fix for the two base address for SMMUv3
> PMCG (now just represent one).
> 
> Thanks
> Hanjun
> 
It's in rev D which is available now:
http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf

Neil
