From: tony@atomide.com (Tony Lindgren)
Date: Mon, 15 Jan 2018 09:52:20 -0800
Subject: PM regression in next
In-Reply-To: <20180115171917.GB12018@sirena.org.uk>
References: <20180112191251.GE21458@sirena.org.uk>
 <20180112210706.GE4821@atomide.com>
 <20180112211535.GH21458@sirena.org.uk>
 <20180112215010.GG4821@atomide.com>
 <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
 <20180112225947.GL21458@sirena.org.uk>
 <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
 <20180115165050.GJ4821@atomide.com>
 <20180115171917.GB12018@sirena.org.uk>
Message-ID: <20180115175220.GK4821@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@kernel.org> [180115 17:19]:
> On Mon, Jan 15, 2018 at 08:50:51AM -0800, Tony Lindgren wrote:
> > * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [180115 01:46]:
> 
> > > I hope your driver will be OK by using regmap.
> > > In worst case, we can back .read/.write, but it will be component driver side.
> 
> > Well we have the merge window about to open in a week, so
> > please just revert the known broken patches.
> 
> Did anyone actually try testing the fix I posted yet?

Hmm I don't seem to have anything in my inbox. What might
be the subject for it?

Regards,

Tony
