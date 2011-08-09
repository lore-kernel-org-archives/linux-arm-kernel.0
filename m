From: koen.beel.barco@gmail.com (Koen Beel)
Date: Tue, 9 Aug 2011 08:25:17 +0200
Subject: GPMI-NAND Status?
In-Reply-To: <4E40C18B.7040609@freescale.com>
References: <20110805135133.GA26981@pengutronix.de>
	<4E3F8087.6070206@freescale.com>
	<CAHMSPgMYP+5Hpa5sC-yt=1H-S=tEER8uNzj6uMSK403_DGYJ9Q@mail.gmail.com>
	<4E40C18B.7040609@freescale.com>
Message-ID: <CAHMSPgNf6V8jYLdxFtznNkvLK-R+YN7gUkfbjrxv0WLTDdJmwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 9, 2011 at 7:11 AM, Huang Shijie <b32955@freescale.com> wrote:
> Hi Koen:
>> Anything is good for me.
>> Could also be useful to make sure we test on the same HW as much as
>> possible and are using the same source tree.
>> HW I have:
>> - mx23evk rev C1
>> - mx23evk rev B2
>> - own target hw using mx23 lqfp-128 chip and different type of ddr and
>> nand.
>>
> My test mx23 board is 169BGA package which is different from yours.
>
> Could you get the 169BGA package board?
>
> I think the DMA timeout is caused by the different package type.

I suppose my mx23evk is right the same as you have (same revision) and
this has the bga169 package. My actual target has lqfp128. But on both
boards I get the same issues.
So I don't think the package type has something to do with the dma
timeout issue. After all the silicon inside is the same thing.

I'm trying to debug a little further.

Regards,
Koen

>
> Best Regards
> Huang Shijie
>
>
>
