From: olof@lixom.net (Olof Johansson)
Date: Sat, 27 Apr 2013 15:12:31 -0700
Subject: [PATCH] ARM: exynos: dts: cros5250: add EC device
In-Reply-To: <CAD=FV=VQg=2R_x11xuGiA0kNj1NXHUM3TUzVJC-F0ZWO39JRdw@mail.gmail.com>
References: <1367019745-31826-1-git-send-email-olof@lixom.net>
 <CAD=FV=WhoGO8=5pt=VOCT_2j2CMkn8on=N=jK_2RwMOXWat57w@mail.gmail.com>
 <20130427010406.GE2350@quad.lixom.net>
 <CAD=FV=VQg=2R_x11xuGiA0kNj1NXHUM3TUzVJC-F0ZWO39JRdw@mail.gmail.com>
Message-ID: <20130427221231.GA10453@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 09:04:56PM -0700, Doug Anderson wrote:
> Olof,
> 
> On Fri, Apr 26, 2013 at 6:04 PM, Olof Johansson <olof@lixom.net> wrote:
> > Ah, yes, of course. As discussed off-mail, I was mislead by some contents in
> > our local tree. :)
> 
> Sorry about that--that was my fault.  Things have landed in a
> different order in one of our local trees.

Yeah, no worries.

> > Kukjin, I'd really like to pick up these patches for 3.10, since they're
> > isolated to just dts changes and gets keyboard working on the Chromebook. Can
> > you ack them and I'll just collect them this time?
> 
> I'm pretty sure that Kukjin is OK with them.  Kukjin responded earlier and said:
> 
> > I'm fine on 2nd and 3rd patches. Shall I take only two patches without 1st
> > one in samsung tree?
> 
> At the time we were waiting for Wolfram to get patch 1 into his tree,
> which is now done.
> 
> ...but waiting for his official Ack is good, too.  ;)


Ah, yes, sounds good. I'll apply these to a late/* branch on arm-soc. It's only
touching cros5250 and snow device trees anyway.

v2 of the patch posted as separate comment.


-Olof
