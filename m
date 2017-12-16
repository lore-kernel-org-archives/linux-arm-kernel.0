From: gengdongjiu@huawei.com (gengdongjiu)
Date: Sat, 16 Dec 2017 10:41:26 +0800
Subject: [PATCH v3] arm64: v8.4: Support for new floating point
 multiplication instructions
In-Reply-To: <73019dea-3e2c-8d03-fe1a-6c54527fa401@arm.com>
References: <1513160036-41377-1-git-send-email-gengdongjiu@huawei.com>
 <73019dea-3e2c-8d03-fe1a-6c54527fa401@arm.com>
Message-ID: <4f13b5a6-b532-ed54-1770-b71b74047078@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi catalin/will,

On 2017/12/13 18:09, Suzuki K Poulose wrote:
> On 13/12/17 10:13, Dongjiu Geng wrote:
>> ARM v8.4 extensions add new neon instructions for performing a
>> multiplication of each FP16 element of one vector with the corresponding
>> FP16 element of a second vector, and to add or subtract this without an
>> intermediate rounding to the corresponding FP32 element in a third vector.
>>
>> This patch detects this feature and let the userspace know about it via a
>> HWCAP bit and MRS emulation.
>>
>> Cc: Dave Martin <Dave.Martin@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 
> Looks good to me.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
hope this patch can be applied to 4.15 kernel version.
Thanks

> 
> .
