From: dianders@chromium.org (Doug Anderson)
Date: Tue, 17 May 2016 17:47:34 -0700
Subject: [PATCH] mmc: dw_mmc: Consider HLE errors to be data and command
 errors
In-Reply-To: <CAD=FV=WFAZqAsXOqunt0fxw87M-FruwUrxuzW0MJsG6UvfSjzA@mail.gmail.com>
References: <1426002490-2014-1-git-send-email-dianders@chromium.org>
 <5502CA4E.9060401@samsung.com>
 <CAD=FV=VX3ix-j4y95W1q8b-aVuVEN+4xsd8WLx2xcE7KPNJwRw@mail.gmail.com>
 <5506707D.40708@samsung.com> <55189F04.8000404@samsung.com>
 <CAD=FV=WFAZqAsXOqunt0fxw87M-FruwUrxuzW0MJsG6UvfSjzA@mail.gmail.com>
Message-ID: <CAD=FV=UJGcwa_biSCGhD=kS-T+fppCniBFfOHb5ohnwSwSwMMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jaehoon,

On Mon, Mar 30, 2015 at 8:47 AM, Doug Anderson <dianders@chromium.org> wrote:
> Jaehoon,
>
> On Sun, Mar 29, 2015 at 5:55 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Dear Doug,
>>
>> I'm considering to control HLE error..So holding this patch.
>> If this is absolutely necessary patch, let me know, plz.
>>
>> Best Regards,
>> Jaehoon Chung
>
> Sounds OK.  I have certainly applied this locally and the driver isn't
> robust against insertions / removals without it, but once the card is
> inserted things are OK so it's probably not urgent that it be applied
> upstream.  Hopefully we can figure out a better solution...

I'm now testing a nice new rebased kernel and I'm hitting this again.

Of course I'll just pick my same patch to my new kernel tree, but
since it's been a year and nobody has done anything better, would you
consider landing my patch?  It is certainly better than nothing.

-Doug
