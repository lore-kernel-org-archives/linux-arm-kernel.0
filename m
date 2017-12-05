From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 5 Dec 2017 14:38:58 +0000
Subject: Tegra baseline test results for v4.15-rc2
In-Reply-To: <027eb309-4c8c-088a-8f12-da51269c1dc2@collabora.com>
References: <acc93fae-7fb0-71c1-c839-8c7b0e6cfb5e@nvidia.com>
 <027eb309-4c8c-088a-8f12-da51269c1dc2@collabora.com>
Message-ID: <a31d99c2-74b6-2c02-ffc5-4fbe0dae7ec6@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/12/17 14:23, Guillaume Tucker wrote:
> On 05/12/17 14:05, Jon Hunter wrote:
>> Here are some basic Tegra test results for Linux v4.15-rc2.
>> Logs and other details at:
>>
>> ??? https://nvtb.github.io//linux/test_v4.15-rc2/20171204140104/
> [...]
>> Boot to userspace: multi_v7_defconfig:
>> ??? FAIL: ( 1/ 5): tegra124-nyan-big
> 
> Thanks for the report.? Following up on the automated bisection
> runs, I've found 2 independent issues that both cause a kernel
> hang on tegra124-nyan-big and sent some patches to address them
> yesterday:
> 
> ?
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/545681.html

Yes, I have seen those and thanks for sending. The above failure is
caused by the CROS EC bug [0]. Lee Jones has picked up the fix which are
now in -next and hopefully, will appear in the mainline soon.

Cheers
Jon

[0] https://patchwork.kernel.org/patch/9974835/

-- 
nvpublic
