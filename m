From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Fri,  1 Jan 2016 14:16:08 +0100 (CET)
Subject: [PATCH 0/1 for 4.4-rc8] ARM: Fix broken USB support in
 sunxi_defconfig
In-Reply-To: <20151231160049.GA23528@lukather>
References: <1451353653-17484-1-git-send-email-public_timo.s@silentcreek.de>
 <4865776.yyMBHQfnua@wuerfel><20151231160049.GA23528@lukather>
Message-ID: <20160101131608.5B9456C803F0@dd34104.kasserver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Maxime Ripard schrieb am 31.12.2015 17:00:

> Hi Arnd,
> 
> On Thu, Dec 31, 2015 at 04:46:01PM +0100, Arnd Bergmann wrote:
>> On Tuesday 29 December 2015 02:47:32 Timo Sigurdsson wrote:
>> > Here is a late patch aimed for 4.4-rc8 (or 4.4). It would be nice if this   
>> > could make it into 4.4 in order to avoid unpleasent surprises (and
>> > subsequent questions) with builds based on sunxi_defconfig. At the moment,
>> > some boards (e.g. LeMaker BananaPi) are left with non-functional USB ports
>> > as a newly added driver is required to power them.
>> 
>> It's a bit confusing to send a patch to so many recipients, that usually
>> leads to nobody applying it. I can put it into the fixes branch in arm-soc
>> but need an Ack from the sunxi maintainer(s).
> 
> You have mine
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Timo, don't we need the same thing for multi_v7?

Yes, we do. I thought I saw it already in there as a module, but that must
have been on linux-next... Anyway, patch will come right away. I take it
your question implies an ack for the multi_v7 patch, too.


Thanks and Happy New Year,

Timo
