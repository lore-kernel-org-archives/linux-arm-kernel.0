From: tony@atomide.com (Tony Lindgren)
Date: Sat, 20 Sep 2014 07:07:12 -0700
Subject: [PATCH V3 3/3] mfd: palmas: Add support for optional wakeup
In-Reply-To: <alpine.DEB.2.10.1409192100380.23826@nanos>
References: <1411067086-16613-4-git-send-email-nm@ti.com>
 <alpine.DEB.2.10.1409181749170.4206@nanos>
 <20140919030333.GA6088@kahuna>
 <alpine.DEB.2.10.1409190710320.5612@nanos>
 <20140919161927.GA28613@kahuna>
 <alpine.DEB.2.10.1409191027330.5612@nanos>
 <20140919191649.GQ14505@atomide.com>
 <alpine.DEB.2.10.1409191233590.4213@nanos>
 <20140919195738.GR14505@atomide.com>
 <alpine.DEB.2.10.1409192100380.23826@nanos>
Message-ID: <20140920140712.GA27096@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Gleixner <tglx@linutronix.de> [140919 19:08]:
> On Fri, 19 Sep 2014, Tony Lindgren wrote:
> > * Thomas Gleixner <tglx@linutronix.de> [140919 12:47]:
> > > Why on earth are you wanting tasklets in there? That's just silly,
> > > really.
> > 
> > Lack of a framework on driver side to cope with this in a generic
> > way? :p
> 
> So instead of creating such a thing we rather have a completely ass
> backward workaround which spreads itself all over the tree?

I'm not kidding, you're the first one who was able to come up with
such a simple solution and also describe why it should be done
that way.
 
> You SoC folks really need a quarterly sanity check.

Probably time for me to file a bios bug on that yeah :)

Regards,

Tony
