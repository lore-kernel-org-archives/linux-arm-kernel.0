From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 13:50:58 -0700
Subject: [PATCH v3 4/6] ARM: dts: omap3-gta04: Add battery support
In-Reply-To: <CAAfyv34oWPgXw4tcy8zZ_vyU9=CxTPFZALVDkqqubAb4R41bvw@mail.gmail.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-5-git-send-email-marek@goldelico.com>
 <20150305003651.GB1033@earth> <20150316203537.GA12397@atomide.com>
 <CAAfyv34oWPgXw4tcy8zZ_vyU9=CxTPFZALVDkqqubAb4R41bvw@mail.gmail.com>
Message-ID: <20150316205057.GC12397@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Belisko Marek <marek.belisko@gmail.com> [150316 13:47]:
> Hi Tony,
> 
> On Mon, Mar 16, 2015 at 9:35 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Sebastian Reichel <sre@kernel.org> [150304 16:41]:
> >> Hi,
> >>
> >> On Wed, Feb 04, 2015 at 11:14:33PM +0100, Marek Belisko wrote:
> >> > Signed-off-by: Marek Belisko <marek@goldelico.com>
> >> > ---
> >> >  arch/arm/boot/dts/omap3-gta04.dtsi | 30 ++++++++++++++++++++++++++++++
> >> >  1 file changed, 30 insertions(+)
> >>
> >> DTS changes must go via omap-dt tree once the driver changes have been
> >> merged.
> >
> > And looks like you wanted to add ti, prefix to the binding. I'll
> > mark this one as read, please repost this one separately once the
> > driver changes are in Linux next.
> ti prefix Iis done in v4 series already [1]
> >
> > Regards,
> >
> > Tony
> 
> [1] - http://lkml.iu.edu/hypermail/linux/kernel/1503.1/02157.html

OK will pick it from there thanks.

Tony
