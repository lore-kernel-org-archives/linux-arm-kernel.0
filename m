From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 26 Apr 2016 18:10:42 +0100
Subject: [PATCH] ARM: debug: remove extraneous DEBUG_HI3716_UART option
In-Reply-To: <5182022.a4Nr98h1hf@wuerfel>
References: <1461590006-1395429-1-git-send-email-arnd@arndb.de>
 <571F2733.6070609@hisilicon.com> <5182022.a4Nr98h1hf@wuerfel>
Message-ID: <571FA112.2050701@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 26/04/2016 12:01, Arnd Bergmann wrote:
> On Tuesday 26 April 2016 09:30:43 Wei Xu wrote:
>> Hi Arnd,
>>
>> On 25/04/2016 14:13, Arnd Bergmann wrote:
>>> DEBUG_HI3716_UART was supposed to be renamed to DEBUG_HIX5HD2_UART, but
>>> accidentally both got left in place, which results in a build error when
>>> CONFIG_DEBUG_UART_PHYS is not set as it should be.
>>>
>>> This removes the old symbol.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Fixes: 12aae3097454 ("ARM: debug: Rename Hi3716 to HIX5HD2")
>>> ---
>>>  arch/arm/Kconfig.debug | 8 --------
>>>  1 file changed, 8 deletions(-)
>>
>> Thanks!
>> Fine to me.
>> Should I pick up it and send a pull request or
>> will you directly pick up it?
> 
> I have put it into the next/cleanup branch now, and added your
> 
>     Acked-by: Wei Xu <xuwei5@hisilicon.com>

Thanks!

Best Regards,
Wei

> 
> Thanks,
> 
> 	Arnd
> 
> .
> 
