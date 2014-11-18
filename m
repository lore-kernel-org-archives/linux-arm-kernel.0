From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 18 Nov 2014 01:39:23 +0100
Subject: mvebu: tclk detection for armada-xp and marvell packet processor
 with integrated CPU
In-Reply-To: <546A71B8.3060606@alliedtelesis.co.nz>
References: <546959A3.9040206@alliedtelesis.co.nz>
 <20141117093437.0ca5a3ef@free-electrons.com>
 <546A5714.2090100@alliedtelesis.co.nz>
 <20141117215543.GC4080@lunn.ch>
 <546A71B8.3060606@alliedtelesis.co.nz>
Message-ID: <CAPv3WKd8_FP=Kc2XiM9u3K3x871LwpvmLiWJ4iaPBXvxag4DWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chris,

2014-11-17 23:07 GMT+01:00 Chris Packham <Chris.Packham@alliedtelesis.co.nz>:
>
>
> On 11/18/2014 10:55 AM, Andrew Lunn wrote:
>>> Yeah I'm still trying to wrestle that information out of Marvell. What I
>>> do know is for the eval board I've got the armada register SAR (offset
>>> 0x18230) is all zeros. I'm not sure if this is because everything really
>>> strapped low or because this register is unused on the PP.
>>
>> Do the CPU SAR pins even make it out of the package? It could be when
>> the synthesised the CPU they hard coded it all and throw away the SAR.
>>
>
> That's a possibility. The other thing that they may have done is
> incorporated the SAR pins for the CPU with the SAR pins for the packet
> processor. That could be a little tricky because then I'd have to start
> opening up windows for the PP registers early in the kernel init.

Sorry to interfere, but is it possible to know what SoC (BobCat2 or
AlleyCat3? Afair, those are the two dual-core pj4b-based ones.) and
board model you exactly work on? I have some experience with this
family, so I there is a chance I may help.

Best regards,
Marcin
