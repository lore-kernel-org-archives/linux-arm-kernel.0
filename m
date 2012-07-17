From: shijie8@gmail.com (Huang Shijie)
Date: Tue, 17 Jul 2012 11:28:32 +0800
Subject: [PATCH 2/2] mtd: gpmi: update the bitflip_threshold
In-Reply-To: <1342471797.25411.31.camel@shinybook.infradead.org>
References: <1341303873-23040-1-git-send-email-b32955@freescale.com>
 <1341303873-23040-2-git-send-email-b32955@freescale.com>
 <1342471797.25411.31.camel@shinybook.infradead.org>
Message-ID: <CAMiH66F5vzEio_tPdORnZ44CwN47arHhyi7jyX_1mEA1=6HQKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 4:49 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2012-07-03 at 16:24 +0800, Huang Shijie wrote:
>> The origin code misses to update the bitflip_threshold when
>> we have already get the right ecc_strength.
>>
>> The patch fixes it.
>>
>> Signed-off-by: Huang Shijie <b32955@freescale.com>
>
> Should we be pushing this for 3.5?
>
I think it's not needed to push this patch for 3.5.

It's okay to merge it in 3.6.


thanks
Huang Shijie

> --
> dwmw2
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
