From: xuwei5@hisilicon.com (Wei Xu)
Date: Mon, 12 Oct 2015 09:11:04 +0100
Subject: [PATCH] ARM: hisilicon: DT: Drop console= and earlyprintk bootargs
 parameter
In-Reply-To: <9558245.SAyWiXU6Yf@wuerfel>
References: <5617E6FC.6090304@hisilicon.com> <9558245.SAyWiXU6Yf@wuerfel>
Message-ID: <561B6B18.1010906@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/9/2015 7:26 PM, Arnd Bergmann wrote:
> On Friday 09 October 2015 17:10:36 Wei Xu wrote:
>> Replace console with stdout-path so that we don't have to put the
>> console on the kernel command line.
>>
>> Remove earlyprintk to allow the kernel to boot on a system even
>> if DEBUG_LL is configured for another system.
>>
>> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
>> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>

Hi Arnd,

> 
> Looks good to me. Do you want us to apply the patch directly, or
> do you plan to send a pull request?

Thanks!
I will send a pull request today.

Best Regards,
Wei

> 
> 	Arnd
> 
> .
> 
