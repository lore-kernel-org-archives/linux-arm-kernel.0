From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sun, 6 Sep 2015 10:40:02 +0800
Subject: [PATCH 0/2] arm64: Support Hisilicon Hip05-D02 board
In-Reply-To: <20150905101854.4f5011bb@arm.com>
References: <1441421939-6236-1-git-send-email-dingtianhong@huawei.com>
 <20150905101854.4f5011bb@arm.com>
Message-ID: <55EBA782.7080403@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/9/5 17:18, Marc Zyngier wrote:
> On Sat, 5 Sep 2015 10:58:57 +0800
> Ding Tianhong <dingtianhong@huawei.com> wrote:
> 
>> Hip05-D02 Development Board is based on Cortex-A57, this patchset
>> contains initial support for Hip05-D02 Soc and Board. Initial support
>> is minimal and includes just the arch configuration, device tree
>> configuration.
>>
>> PSCI is enabled in device tree and there is no problem to boot all the
>> 16 cores, and the CPU hotplug is also working now, you can download and
>> compile the latest firmware based on the following link to run this
>> patch set.
>>
>> https://github.com/hisilicon/estuary/blob/master/README
>>
>> v1->v2:
>> - 1. Change the compatible name for per CPU.
>>   2. Remove the GIC_CPU_MASK_SIMPLE(xx) which is not used for gicv3
>>      from hip05.dtsi.
> 
> Please always indicate the version number in the email subject ("PATCH
> v2" is the usual scheme). It makes it otherwise difficult to keep track
> of what version I am looking at.
> 
> Thanks,
> 
Miss it, fix it in next version, thanks.

Ding


> 	M.
> 
