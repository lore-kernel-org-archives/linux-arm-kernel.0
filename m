From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 3 Aug 2012 10:06:06 +0200
Subject: [PATCH 1/1] ARM: OMAP3: igep0020: set GPIO mode for mux
 mcspi1_cs2 pin
In-Reply-To: <20120718072052.GK6522@atomide.com>
References: <1341885452-5372-1-git-send-email-javier@dowhile0.org>
 <CAFqH_511c6CyAYnbtU0ECZwzRNwJEdTqtcZ63nODCYZU4GC0aA@mail.gmail.com>
 <CABxcv=miEavW5Qf-Y+S4Nph+ah5gQ6QDpt-T44tdHLBxcP8pqQ@mail.gmail.com>
 <20120718072052.GK6522@atomide.com>
Message-ID: <CABxcv=kueP=UA6sQwS8Hs-s3vyAX+RhJgkHmyWWAVb668y-EOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 9:20 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Javier Martinez Canillas <javier@dowhile0.org> [120717 00:16]:
>>
>> Hi Tony,
>>
>> Just pinging to see if you have further comments on this patch or if
>> it can be applied. It solves a bug on IGEPv2 boards.
>>
>> I know the trend is to move away from board code. I'll start working
>> on an device tree for the IGEPv2 but it will take some time until is
>> ready (and I'm not sure if all the OMAP3 support is already present on
>> DT).
>>
>> So could you please take bug fixes for the board code in the meantime?
>
> Yes seems like something for the v3.6-rc series.
>
> Regards,
>
> Tony

Hi Tony,

I saw that Linus 3.6-rc1 has already been released and I didn't see
this patch on it.

So, this is a kindly reminder so you don't miss this patch :-)

Thanks a lot and best regards,
Javier
