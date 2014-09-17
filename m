From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 17 Sep 2014 15:53:06 +0200
Subject: [PATCH 1/7] ARM: add mach-asm9260
In-Reply-To: <20140917134646.GF27054@piout.net>
References: <1410646408-28901-1-git-send-email-linux@rempel-privat.de>
 <1410646408-28901-2-git-send-email-linux@rempel-privat.de>
 <20140914071206.GP21986@titan.lakedaemon.net>
 <54154780.80203@rempel-privat.de>
 <20140914090545.GA21986@titan.lakedaemon.net>
 <20140917134646.GF27054@piout.net>
Message-ID: <54199242.5020404@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/09/2014 15:46, Alexandre Belloni :
> Hi,
> 
> On 14/09/2014 at 05:05:45 -0400, Jason Cooper wrote :
>> On Sun, Sep 14, 2014 at 09:45:04AM +0200, Oleksij Rempel wrote:
>>> Am 14.09.2014 um 09:12 schrieb Jason Cooper:
>>>> On Sun, Sep 14, 2014 at 12:13:22AM +0200, Oleksij Rempel wrote:
>>>>
>>>> Could you please add a description of the SoC?  Perhaps a link to
>>>> documentation, or at least a slick sheet?  Also, are there any products
>>>> on the market with this SoC, which ones?
>>>>
>>>> thx,
>>>
>>> Hi,
>>>
>>> it is low cost (?) SoC targeted for market in China and India which
>>> trying to "replace" AT91SAM9G25.

Well, I won't say "replace" but "compete with" Atmel AT91SAM9G25.
AT91SAM9G25 is here to stay ;-)

>>> Here is some info:
>>> http://www.alphascale.com/index.asp?ics/615.html
>>>
>>> One of products:
>>> http://www.aliexpress.com/store/product/2014-hot-sales-FREE-SHIPPING-new-Purple-core-ARM9-development-board-ASM9260T-SDRAM-power-line/433637_1931495721.html
>>
>> Ok, please include this information is the commit log of the next
>> version of this patch.
>>
> 
> I would also suggest to call it AlphaScale instead of Alpscale as it
> allows to get more useful information when searching the web.
> 


-- 
Nicolas Ferre
