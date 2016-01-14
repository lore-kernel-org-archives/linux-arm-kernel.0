From: vw@iommu.org (Wan Zongshun)
Date: Thu, 14 Jan 2016 17:34:33 +0800
Subject: [PATCH] mtd: nuc900_nand: read correct SMISR register
In-Reply-To: <20160114002900.GA54220@google.com>
References: <9019174.GYajdpGP8V@wuerfel> <20160113215013.GS109450@google.com>
 <5830403.0pR8UVXPRZ@wuerfel> <20160114002900.GA54220@google.com>
Message-ID: <56976BA9.2040709@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-------- Original Message --------
> On Wed, Jan 13, 2016 at 11:02:06PM +0100, Arnd Bergmann wrote:
>> On Wednesday 13 January 2016 13:50:13 Brian Norris wrote:
>>>
>>> Looks OK to me, though I kinda hate dragging on support for
>>> obviously-unused drivers...
>>
>> Should we mark that driver in Kconfig as obviously broken then?
>
> Well, it won't be obviously broken if I apply your patch... But if
> that's the right step toward removal, then I could be OK with that.
>
>> Let's wait for Wan ZongShun to reply first, it's possible that the
>> entire w90x900 platform has come to the point where we are better off
>> removing it than fixing ancient bugs.
>
> Sounds good.

Actually, Nuvoton should still leverage this upstream w90x900 codes for 
their old and new arm chip BSP, but I am not sure their open source plan 
for the new chip now, I will check with Nuvoton for this topic, and give 
you feedback here, so please hold on its removal.

>
> Brian
>
