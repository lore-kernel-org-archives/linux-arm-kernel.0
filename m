From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 May 2012 08:23:33 -0700
Subject: [GIT PULL 1/10] omap non-critical fixes for v3.5 merge window
In-Reply-To: <CAOesGMg-_KOTrrho1LeLhd0sevUG8hTTacgtwuzCP=BUZJ9VmA@mail.gmail.com>
References: <4fac0be2.e9a0320a.1f37.7e70SMTPIN_ADDED@mx.google.com>
 <CAOesGMi0+fty-x1kq0qo+msya=p5xyQDsB9iFrtht38Rn5V=Eg@mail.gmail.com>
 <alpine.DEB.2.00.1205110231120.3201@utopia.booyaka.com>
 <CAOesGMg-_KOTrrho1LeLhd0sevUG8hTTacgtwuzCP=BUZJ9VmA@mail.gmail.com>
Message-ID: <20120511152332.GS21851@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [120511 01:41]:
> On Fri, May 11, 2012 at 1:33 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > Hello Olof,
> >
> > On Fri, 11 May 2012, Olof Johansson wrote:
> >
> >> I did notice that omap2plus_defconfig has grown a new warning caused
> >> by "ARM: OMAP2+: clean up some cppcheck warnings" (oh, the irony!):
> >>
> >> arch/arm/plat-omap/usb.c: In function 'omap_otg_init':
> >> arch/arm/plat-omap/usb.c:40:6: warning: unused variable 'status'
> >> [-Wunused-variable]
> >
> > Thanks, this has been fixed by:
> >
> > http://marc.info/?l=linux-omap&m=133660322929805&w=2
> 
> Sounds good, I'll wait for it to trickle in on a future pull request.

Thanks I'll see if there's some other fixes still needed and
send a pull request today.

Regards,

Tony
