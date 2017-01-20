From: dingtianhong@huawei.com (Ding Tianhong)
Date: Fri, 20 Jan 2017 09:22:12 +0800
Subject: [PATCH v9 0/4] arm64: arch_timer: Add workaround for
 hisilicon-161010101 erratum
In-Reply-To: <23512329-e8d9-4b4f-c460-4d769ef7102e@arm.com>
References: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
 <23512329-e8d9-4b4f-c460-4d769ef7102e@arm.com>
Message-ID: <a8f1f48d-6f59-7252-90ba-9e8a56c218d1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2017/1/19 21:49, Marc Zyngier wrote:
> On 19/01/17 13:35, Ding Tianhong wrote:
>> Erratum Hisilicon-161010101 says that the ARM generic timer counter "has the
>> potential to contain an erroneous value when the timer value changes".
>> Accesses to TVAL (both read and write) are also affected due to the implicit counter
>> read.  Accesses to CVAL are not affected.
> 
> Please. 3 series in 2 hours is not fun, and is not helping your case
> either. Give us the time to properly review your patches, and wait until
> we ask you to respin if we think that this is required.
> 
> Thanks,
> 

OKo<
Thank you for your correction.

Thanks
Ding

> 	M.
> 
