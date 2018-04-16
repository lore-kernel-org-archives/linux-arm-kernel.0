From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Apr 2018 11:20:32 +0100
Subject: [PATCH] KVM: arm/arm64: Close VMID generation race
In-Reply-To: <5AD47578.7010103@huawei.com>
References: <20180409170706.23541-1-marc.zyngier@arm.com>
 <20180409205139.GH10904@cbox>
 <20180410105119.yzzzd4lyvlsvtbfy@lakrids.cambridge.arm.com>
 <20180410150540.GK10904@cbox>
 <20180410152419.inzprhuqhx26keuq@lakrids.cambridge.arm.com>
 <f90f8486-10c7-ce42-94a8-abaabd80ebb7@arm.com> <5ACD6521.5090500@huawei.com>
 <5AD47578.7010103@huawei.com>
Message-ID: <09e4f259-a49b-8a5a-6b75-7dacfd90fb0e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/04/18 11:05, Shannon Zhao wrote:
> 
> 
> On 2018/4/11 9:30, Shannon Zhao wrote:
>>
>> On 2018/4/10 23:37, Marc Zyngier wrote:

[...]

>>>> I don't mind either way. If you can be bothered to write a proper commit
>>>> log for this, I'll take it. What I'd really want is Shannon to indicate
>>>> whether or not this solves the issue he was seeing.
>>>>
>> I'll test Marc's patch. This will take about 3 days since it's not 100%
>> reproducible.
> Hi Marc,
> 
> I've run the test for about 4 days. The issue doesn't appear.
> So Tested-by: Shannon Zhao <zhaoshenglong@huawei.com>

Thanks Shannon, much appreciated. I'll send the fix upstream towards the
end of the week.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
