From: martinez.javier@gmail.com (Javier Martinez Canillas)
Date: Wed, 9 May 2012 15:30:41 +0200
Subject: [RESEND PATCH 1/2] ARM: OMAP2+: nand: Make board_onenand_init()
 visible to board code
In-Reply-To: <20120508231653.GP5088@atomide.com>
References: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
 <CAFqH_52aiDvR_xHY6TUN7igMiq6EqB-Nx9D=sPMCUeUaKLiuQg@mail.gmail.com>
 <CABxcv=kXukrVYOzjrMGoWzi=GTefh8EsXnTwzcahsfLa1a6Kaw@mail.gmail.com>
 <20120508231653.GP5088@atomide.com>
Message-ID: <CAAwP0s3_9FwetsYsrQbLL45Wb6wyxMdLLQR3b1cPS4AamY0qxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 1:16 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Javier Martinez Canillas <javier@dowhile0.org> [120427 02:33]:
>> On Wed, Apr 25, 2012 at 9:59 AM, Enric Balletb? i Serra
>> <eballetbo@gmail.com> wrote:
>> >
>> > Tony, as this is a fix ,may be included ?
>> >
>> > Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>> > Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>> >
>> > Cheers,
>> > ? ?Enric
>>
>> Hi Tony, Russel:
>>
>> This patch is a requirement for patch:
>>
>> [RESEND PATCH 2/2] OMAP3: igep0020: Add support for Micron NAND Flash
>> storage memory
>>
>> which is really important since newer IGEPv2 boards have changed their
>> flash memory from OneNAND to NAND.
>>
>> This patch-set is necessary to make the board work, otherwise it
>> doesn't even boot.
>>
>> Could we please include these patches?
>
> Thanks for the patience, applying now into board branch finally.
>
> Regards,
>
> Tony
> --

Hi Tony,

Thanks a lot for applying these patches.

Best regards,
Javier
