From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 15 Nov 2017 17:15:07 +0800
Subject: [PATCH v4 00/21] SError rework + RAS&IESB for firmware first
 support
In-Reply-To: <5A0B13B5.3000205@arm.com>
References: <20171019145807.23251-1-james.morse@arm.com>
 <5A049B20.6000501@arm.com> <20171113112946.GK14144@cbox>
 <5A0B13B5.3000205@arm.com>
Message-ID: <e0dea261-a9ef-9d00-682a-a4449d1de5ec@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi james,

On 2017/11/15 0:03, James Morse wrote:
>> Hope this helps?
> Yes, I'll go looking for a way to expose VSESR_EL2 to user-space.

what is the purpose to expose VSESR_EL2?
do you mean set its value after migration?

May be we can use similar below Mechanism
https://www.spinics.net/lists/arm-kernel/msg603525.html

when user-space sync the register status, it will get these register value.
it will reuse the IOCTL KVM_GET_ONE_REG and no need to add extra API.

> 
> 
> Thanks!
> 
> James
