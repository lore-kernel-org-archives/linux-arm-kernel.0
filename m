From: olof@lixom.net (Olof Johansson)
Date: Fri, 26 Apr 2013 18:04:06 -0700
Subject: [PATCH] ARM: exynos: dts: cros5250: add EC device
In-Reply-To: <CAD=FV=WhoGO8=5pt=VOCT_2j2CMkn8on=N=jK_2RwMOXWat57w@mail.gmail.com>
References: <1367019745-31826-1-git-send-email-olof@lixom.net>
 <CAD=FV=WhoGO8=5pt=VOCT_2j2CMkn8on=N=jK_2RwMOXWat57w@mail.gmail.com>
Message-ID: <20130427010406.GE2350@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 04:56:51PM -0700, Doug Anderson wrote:
> Olof,
> 
> On Fri, Apr 26, 2013 at 4:42 PM, Olof Johansson <olof@lixom.net> wrote:
> > Add basic EC information to device tree, currently only describing the
> > keyboard and keymap.
> >
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > Cc: Doug Anderson <dianders@chromium.org>
> > ---
> >
> > Kukjin, I'll apply this too directly if you don't mind.
> >
> >
> > -Olof
> >
> >  arch/arm/boot/dts/cros5250-common.dtsi | 99 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 98 insertions(+), 1 deletion(-)
> 
> I'm not a huge fan of this change as I'd rather see my arbitration
> changes land first and see this based atop those.  The arbitration
> driver has landed so all that's left are the device tree bits.
> 
> That would be:
> 
> https://patchwork.kernel.org/patch/2449961/
> https://patchwork.kernel.org/patch/2449941/
> 
> ...but other than that this looks good.

Ah, yes, of course. As discussed off-mail, I was mislead by some contents in
our local tree. :)

Kukjin, I'd really like to pick up these patches for 3.10, since they're
isolated to just dts changes and gets keyboard working on the Chromebook. Can
you ack them and I'll just collect them this time?

I'll repost a version that goes on top of Doug's patches.


-Olof
