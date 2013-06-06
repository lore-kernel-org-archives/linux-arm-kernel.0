From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Jun 2013 19:28:10 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <CAOesGMgqxhG45NyCfpHc_0uHS+_Gn-hGZm-+CRvK2EEf1AGTow@mail.gmail.com>
References: <51AFA6DD.3000202@wwwdotorg.org>
 <CAPweEDz=hFxXW3XF9CSNZpEFSjayb5an1E8Xze1_uQcCZONVxg@mail.gmail.com>
 <1370469574.18839.33.camel@localhost>
 <CAPweEDxMpeJc-w=Yd7d2OT=UisRBp2rxf-MPMDUCOG3EyJz1GQ@mail.gmail.com>
 <CAKON4OxwyV2f_iTEb5RnP_azc7EsSxPdku_TY5WLWxN7USiY1Q@mail.gmail.com>
 <CAPweEDw1BabE0cmT5fxZ3Z9p9EH508M3Nzcqk2VcO0oz-qYsvg@mail.gmail.com>
 <1370475609.20454.44.camel@localhost>
 <CAPweEDwS3tR=wh-bZJb3vqR8fVQra=3XxDitowGRdH9c7WRfmQ@mail.gmail.com>
 <CAKON4OxPDpN3BTc9GWP44exDSkAZGJ5OeCpUP37vRnnvxwUnmw@mail.gmail.com>
 <CAOesGMgqxhG45NyCfpHc_0uHS+_Gn-hGZm-+CRvK2EEf1AGTow@mail.gmail.com>
Message-ID: <20130606172810.GE14209@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

On Thu, Jun 06, 2013 at 09:00:00AM -0700, Olof Johansson wrote:
> On Thu, Jun 6, 2013 at 8:13 AM, jonsmirl at gmail.com <jonsmirl@gmail.com> wrote:
> > On Wed, Jun 5, 2013 at 7:54 PM, luke.leighton <luke.leighton@gmail.com> wrote:
> >>  augh.  ok.  solutions.  what are the solutions here?
> >
> > Luke if you really want to fix this a good solution is to have
> > Allwinner join Linaro and provide an engineer to the Linaro effort.
> > That engineer will get educated on the right way to do kernel
> > development and he can pass that knowledge back to Allwinner each day
> > as he learns it.
> 
> There's no need for anybody to join Linaro to contribute upstream.
> That's a crazy notion.
> 
> Listen, Allwinner isn't working in a vacuum, believe it or not. I've
> talked to them, so has Arnd and other people working on ARM, including
> Maxime Ripard, who's been reimplementing upstream support for their
> platform. Everybody is interested in the right things happening, it's
> just a matter of figuring out how to do it. The right people are
> already talking.

I should also add that Allwinner not only talked to us already, but also
expressed interest in doing actual modern kernel development (like using
"recently" introduced kernel frameworks, like the clk framework).

I've received patches from them already for private reviews, they began
to show up on the kernel mailing lists, they asked to be CCed on the
patches I send upstream, they're even the one that reached out to me
when the early support for their chips was released. So, like Olof said,
they aren't in a vacuum, they are very aware of the mainline kernel and
speak a decent english.

So yes, Allwinner has an evil vendor tree (c), with a solution similar yet
inferior (because not generic enough) to the device tree, but they show
interest on going down the mainline road.
