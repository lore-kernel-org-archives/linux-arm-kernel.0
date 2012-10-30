From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Tue, 30 Oct 2012 16:44:51 +0100
Subject: [PATCH] mmc: at91-mci: remove driver
In-Reply-To: <87a9v4otqh.fsf@octavius.laptop.org>
References: <1351520875-31891-1-git-send-email-ludovic.desroches@atmel.com>
 <87625txrou.fsf@octavius.laptop.org>
 <20121030150113.GB19021@game.jcrosoft.org>
 <87ehkgov3a.fsf@octavius.laptop.org>
 <20121030153350.GC19021@game.jcrosoft.org>
 <87a9v4otqh.fsf@octavius.laptop.org>
Message-ID: <508FF5F3.2020104@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 10/30/2012 04:38 PM, Chris Ball a ?crit :
> Hi,
>
> On Tue, Oct 30 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 11:09 Tue 30 Oct     , Chris Ball wrote:
>>> Hi,
>>>
>>> On Tue, Oct 30 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>> Thanks!  Pushed to mmc-next for 3.8.
>>>>
>>>> if you don't mind I prefer to take it via at91
>>>>
>>>> I've a patch series that cleanup the platform_data it's difficult to merge
>>>> with this one
>>>
>>> Hm, I don't understand why it should be difficult to merge.  Is it
>>> because this patch modifies arch/arm/mach-at91/include/mach/board.h?
>>>
>>> If so, sounds like we should just take that change out of this patch
>>> and have it go into your platform data cleanup patch, and then I can
>>> merge the drivers/mmc change independently?  Let me know what you think.
>> I'm modifing and moiving the board.h so this file will not exist anymore
>>
>> and the platform data are not anymore in arch/arm/mach-at91/include/mach/board.h
>
> Can we take the modification of board.h out of this patch, then,
> leaving just the drivers/mmc/ changes?

Yes I can remove board.h changes from the patch. Jean-Christophe, do you 
agree too?


Ludovic

>
> - Chris.
>
