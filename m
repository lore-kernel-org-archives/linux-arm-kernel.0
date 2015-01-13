From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Jan 2015 07:56:35 -0800
Subject: [PATCH v4 3/3] arm: dts: omap3-gta04: Add handling for tv output
In-Reply-To: <54B4EF43.50300@ti.com>
References: <1417642402-20538-1-git-send-email-marek@goldelico.com>
 <1417642402-20538-4-git-send-email-marek@goldelico.com>
 <54B4EF43.50300@ti.com>
Message-ID: <20150113155634.GD2419@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [150113 02:14]:
> On 03/12/14 23:33, Marek Belisko wrote:
> > Add handling for gta04 tv out chain:
> > venc -> opa362 -> svideo
> > 
> > Use invert-polarity in venc node because opa362
> > is doing polarity inversion also.
> > 
> > Signed-off-by: Marek Belisko <marek@goldelico.com>
> > ---
> >  arch/arm/boot/dts/omap3-gta04.dtsi | 49 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> 
> Looks fine to me.
> 
> Tony, do you want to pick this up? I can take the first two patches via
> fbdev.

OK will pick the dtsi change.

Thanks,

Tony
