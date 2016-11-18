From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Nov 2016 10:58:31 -0800
Subject: [GIT PULL] add #pinctrl-cells for v4.10
In-Reply-To: <20161118175629.GC8882@localhost>
References: <582a5813.1bc0620a.e65a9.b2cbSMTPIN_ADDED_BROKEN@mx.google.com>
 <20161118175629.GC8882@localhost>
Message-ID: <20161118185830.GW4082@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [161118 10:49]:
> Hi,
> 
> On Mon, Nov 14, 2016 at 04:34:19PM -0800, Tony Lindgren wrote:
> > The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> > 
> >   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/pinctrl-cells-signed
> > 
> > for you to fetch changes up to be76fd3197df608e1b010bf5ab90377205f54344:
> > 
> >   ARM: dts: Add #pinctrl-cells for pinctrl-single instances (2016-11-07 08:27:49 -0700)
> > 
> > ----------------------------------------------------------------
> > Add #pinctrl-cells for pinctrl-single using dts files. This allows
> > us to use generic parser later on. Note that the driver supports
> > handling the legacy binding also with no #pinctrl-cells so these
> > changes can be queued separately from the driver changes.
> 
> You forgot to make one commit per file to maximize your patch contribution
> count! :-)

Heh I've got plenty of churn commits already :)

> Merged, but note that we normally keep arm64 and arm DT updates
> separate. I'm gambling on not seeing any conflicts on the hi6220 dtsi
> this time around though, and took it in as-is.

Oh right, sorry about that. I'll split n * arch ways next time.

Regards,

Tony
