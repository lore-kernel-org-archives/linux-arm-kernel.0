From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 26 Apr 2016 08:46:21 +0100
Subject: [GIT PULL v2] arm64: hisilicon: config changes for 4.7
In-Reply-To: <6854260.KJI50JSxh6@wuerfel>
References: <5714F86A.40001@hisilicon.com> <6854260.KJI50JSxh6@wuerfel>
Message-ID: <571F1CCD.6070309@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 25/04/2016 20:21, Arnd Bergmann wrote:
> On Monday 18 April 2016 16:08:26 Wei Xu wrote:
>> Please help to pull the following changes.
>>
>> I based this pull request on v4.6-rc4 instead of rc1 to avoid the
>> duplication that some configurations have been enabled.
>>
>>
> 
> Hi Wei,
> 
> Unfortunately basing it on top of -rc4 causes us more problems than
> it solves. If at all possible, can you rebase on top of -rc3 or earlier?
> 
> The problem is backmerging code from mainline into arm-soc, as that
> makes it ambiguous later when we send the pull request to Linus regarding
> which changes are coming from us or not.

OK. I will send a new one based on rc3 soon.
Thanks!

Best Regards,
Wei

> 
> 	Arnd
> 
> .
> 
