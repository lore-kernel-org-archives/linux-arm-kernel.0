From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 10 Apr 2015 18:13:09 +0800
Subject: [PATCH 0/2] Enable HiSilicon hip04 ethernet controller
In-Reply-To: <15355533.8BHqyIEd6L@wuerfel>
References: <1428650180-9746-1-git-send-email-fathi.boudra@linaro.org>
 <15355533.8BHqyIEd6L@wuerfel>
Message-ID: <5527A235.9050601@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/4/10 17:06, Arnd Bergmann wrote:
> On Friday 10 April 2015 10:16:18 Fathi Boudra wrote:
>> The following patches enable the ethernet controller on HiSilicon hip04
>> as documented in the device tree binding but not currently enabled.
>> It has been tested on real hardware with tftp boot + NFS root filesystem.

Hi Fathi and Arnd
> The patches looks ok to me, but we don't normally pick up changes like
> this from developers, you should address them to Wei Xu so he can send
> them to arm-soc along with his other changes.

Thanks!
I will test it and prepare the pull request with other changes.

> Note that there are some known bugs in this driver, I sent an experimental
> patch for some of them but never heard back.

I will contact with tianhong and zhangfei about it.
Thanks!

Best Regards,
Wei

> 	Arnd
> 
> .
> 
