From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 15 Aug 2017 22:08:36 +0200
Subject: [PATCH 2/4] drm/tve200: Add new driver for TVE200
In-Reply-To: <CACRpkdZ_rBooDmHXYQZw=M_y36u-vfVLdsP4XTh0Sf2oCHaA2Q@mail.gmail.com>
References: <20170813151132.24736-1-linus.walleij@linaro.org>
 <20170813151132.24736-3-linus.walleij@linaro.org>
 <20170814142015.dy73yguwmuglloiz@phenom.ffwll.local>
 <CACRpkdZ_rBooDmHXYQZw=M_y36u-vfVLdsP4XTh0Sf2oCHaA2Q@mail.gmail.com>
Message-ID: <CAKMK7uHLOP8yYug17Rb5XFn6pfHwm8w74Lmzwn3twfz4Wb2f=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 10:02 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Mon, Aug 14, 2017 at 4:20 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>
>> Wrt merging/maintaining: Want to include it in the drm-misc pile? We'll
>> happily throw commit rights at every driver submission (and honestly
>> expect that, since it helps tremendously with balance maintainer loads for
>> the oddball trivial patch).
>
> Yeah I'm game for it :)
>
> I need to reiterate the patch addressing yours and Eric's comments first.
>
> I *really* want to experience your development workflow first hand after
> seeing your talks, so it'll be exciting. Just tell me how to proceed with
> this and/or point me to the right docs and I'll get going with it.

You need an fd.o account with acess to drm-misc.

https://www.freedesktop.org/wiki/AccountRequests/

Meanwhile enjoy the docs:

https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
https://01.org/linuxgraphics/gfx-docs/maintainer-tools/dim.html

(we have patches in flight to make it into a neat sphinx-style book
like the kerneldocs now are)

Then grab dim (our script)
https://cgit.freedesktop.org/drm-intel/tree/dim?h=maintainer-tools

Adjust dimrc to your taste and run dim setup (that will also grab a
checkout of all the maintainer-tools so that it autoupdates). There's
a bunch of howtos all around, and once fully installed there's also
bash completion and stuff like that.

If you hit a snag, best way to get help is over #dri-devel on
freenode. That's also where we tend to organize/coordinate review and
stuff. Also if anything is uncool with the tools pls pipe up, we
constantly try to make them better.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
