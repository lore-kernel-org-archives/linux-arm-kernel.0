From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 May 2014 13:00:43 -0400
Subject: [PATCHv2 1/4] of: make of_update_property() usable earlier in
 the boot process
In-Reply-To: <CAL_JsqJhKy=whJE25me07YFxEMX+gCch42ZF_Z5_5xfsfAvFXA@mail.gmail.com>
References: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399975839-5311-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_JsqLNnLjeo2tM=z5bcn4DJD_5-uFRGkk6wAWnvGZyo9Y7pg@mail.gmail.com>
 <20140513163026.18a0fa61@free-electrons.com>
 <20140513153006.GC27822@titan.lakedaemon.net>
 <20140513175404.319d067d@free-electrons.com>
 <CAL_JsqJhKy=whJE25me07YFxEMX+gCch42ZF_Z5_5xfsfAvFXA@mail.gmail.com>
Message-ID: <20140513170043.GG27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 11:58:08AM -0500, Rob Herring wrote:
> On Tue, May 13, 2014 at 10:54 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > Dear Jason Cooper,
> >
> > On Tue, 13 May 2014 11:30:06 -0400, Jason Cooper wrote:
> >
> >> > Well, I guess it's a per-maintainer choice:
> >> >
> >> > git log | grep "^Fixes:"
> >> >
> >> >     Fixes: 54fe26a900bc528f3df1e4235cb6b9ca5c6d4dc2 ('ARM: mvebu: Add thermal quirk for the Armada 375 DB board')
> >>
> >> Well, just because the maintainer is an idiot and didn't catch it isn't
> >> an excuse to continue the behavior. ;-)
> 
> To be fair, documentation was added last week! I only noticed now
> because I just found and read the documentation. In the future, I'll
> probably forget and not notice thus becoming an idiot again. ;)

um.. I thought that was me.  I usually don't make it a habit of calling
other people idiot.  I reserve that for myself. ;-)

thx,

Jason.
