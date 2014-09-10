From: dianders@chromium.org (Doug Anderson)
Date: Wed, 10 Sep 2014 10:19:28 -0700
Subject: [PATCH] clocksource: arch_timer: Fix code to use physical timers
 when requested
In-Reply-To: <20140910155509.GA7519@leverpostej>
References: <CAOesGMjK65Rc-K0fyFUUJLw6huLT82E-nqJwZO4PqhgopF96Ow@mail.gmail.com>
 <CAPz6YkWAPtuy4sAuAK9GtpDgfGsccxeS+pqqe_t_R818Jt01qA@mail.gmail.com>
 <53FE5B09.2020403@codeaurora.org>
 <CAOesGMhTivDzJFuxONggcJ6N5UvZopKa=+tv9PoPX593cpnm0A@mail.gmail.com>
 <53FE7E3B.1010500@codeaurora.org>
 <CAOesGMgXnsqttHwAxEW4a7-Rx-nmSwpJd_Dt1iCcFOvzDwbzdA@mail.gmail.com>
 <CAD=FV=VjN6Xam-nRRcxvOoN-gokU6DbGVjoPXN_fkTJssH1RWA@mail.gmail.com>
 <20140828093505.GC14650@leverpostej>
 <CAD=FV=UwfP0x-bswbtV_eUvpKeOSNnsVVLTE3VHguyhm_jiSug@mail.gmail.com>
 <54106707.4010006@codeaurora.org>
 <20140910155509.GA7519@leverpostej>
Message-ID: <CAD=FV=URg=vQbOqkg57Uujs4UWv8OKEjY+3Rx=7jbgab5pgoBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Wed, Sep 10, 2014 at 8:55 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> That's not true in general as other secure initialization will still be
> necessary, and the extent and character of that initialization is going
> to be implementation specific.

Can you give more examples of what you mean by implementation
specific?  Does this mean that secure initialization will be different
for every SoC out there?  ...or is it just different for different ARM
cores?

-Doug
