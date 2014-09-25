From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 25 Sep 2014 17:44:24 +0900
Subject: [PATCH v3] ARM: dts: add CPU nodes for Exynos4 SoCs
In-Reply-To: <5423D23C.5010204@gmail.com>
References: <5230569.XLlNbB5NvF@amdc1032>
 <018e01cfd885$770dd940$65298bc0$@kernel.org>
 <20140925081704.GA20841@e102568-lin.cambridge.arm.com>
 <5423D19B.1040203@samsung.com> <5423D23C.5010204@gmail.com>
Message-ID: <5423D5E8.1050008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/14 17:28, Tomasz Figa wrote:
> Hi Kukjin,
>
> On 25.09.2014 10:26, Kukjin Kim wrote:
>> On 09/25/14 17:17, Lorenzo Pieralisi wrote:
>>> [CC'ed Daniel to make him aware this patch goes through your tree]
>>>
>> Thanks and just note the branch  which is including this change actually
>> v4 is just rebased not v3 will be sent out to arm-soc last tonight or
>> tomorrow.

v3 is correct :) sorry, I confused the version...

>
> Could you keep this patch in a separate stable branch, so I could pull
> it as a dependency for Thomas Abraham's cpufreq series?
>
It's possible, but would be better that DT changes are sent to upstream 
through samsung/arm-soc tree?...we suffered ugly conflicts between 
arm-soc and driver before and then we decided DT changes should be 
handled in arm-soc...Hmm...

- Kukjin
