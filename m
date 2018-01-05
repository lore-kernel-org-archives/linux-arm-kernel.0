From: gengdongjiu@huawei.com (gengdongjiu)
Date: Fri, 5 Jan 2018 16:22:24 +0800
Subject: [PATCH v3] arm64: v8.4: Support for new floating point
 multiplication instructions
In-Reply-To: <20180105075732.GA8801@kroah.com>
References: <1513160036-41377-1-git-send-email-gengdongjiu@huawei.com>
 <73019dea-3e2c-8d03-fe1a-6c54527fa401@arm.com>
 <cae4f913-6d75-e92c-1add-247b07efaf9d@huawei.com>
 <20180105075732.GA8801@kroah.com>
Message-ID: <b3431080-4689-e66e-ae0f-d0e263cdd47d@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/1/5 15:57, Greg KH wrote:
> On Fri, Jan 05, 2018 at 09:22:54AM +0800, gengdongjiu wrote:
>> Hi will/catalin
>>
>> On 2017/12/13 18:09, Suzuki K Poulose wrote:
>>> On 13/12/17 10:13, Dongjiu Geng wrote:
>>>> ARM v8.4 extensions add new neon instructions for performing a
>>>> multiplication of each FP16 element of one vector with the corresponding
>>>> FP16 element of a second vector, and to add or subtract this without an
>>>> intermediate rounding to the corresponding FP32 element in a third vector.
>>>>
>>>> This patch detects this feature and let the userspace know about it via a
>>>> HWCAP bit and MRS emulation.
>>>>
>>>> Cc: Dave Martin <Dave.Martin@arm.com>
>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>>>> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
>>>
>>> Looks good to me.
>>>
>>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>>  sorry to disturb you. Reminder, hope this patch can be applied to Linux 4.15-rc7.
> 
> New features should not be going into 4.15-rc, that should be a 4.16-rc1
> thing, right?

It is also great if it can be applied to 4.16-rc1. Thanks a lot!


> 
> thanks,
> 
> greg k-h
> 
> .
> 
