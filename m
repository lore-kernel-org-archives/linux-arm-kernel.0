From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Mar 2015 09:15:40 +0000
Subject: [GIT PULL v2] of: Add of-graph helpers to loop over endpoints
 and find ports by id
In-Reply-To: <2376013.jScnaqPlDa@phil>
References: <1425369592.3146.14.camel@pengutronix.de>
 <CAL_Jsq+s5RN+7z8Q5N1VghxaQ_ajQmBddtWOTovLoVJjb_6uDw@mail.gmail.com>
 <1426063881.3101.33.camel@pengutronix.de> <2376013.jScnaqPlDa@phil>
Message-ID: <20150324091540.GU8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 05:29:02PM +0100, Heiko Stuebner wrote:
> Hi Rob, Philipp,
> 
> Am Mittwoch, 11. M?rz 2015, 09:51:21 schrieb Philipp Zabel:
> > Am Dienstag, den 10.03.2015, 14:05 -0500 schrieb Rob Herring:
> > > I've only been copied on this latest pull request and a version from
> > > March of last year which Grant nak'ed. This series did not go to
> > > devicetree list either. I'll take a look at the series.
> > 
> > My bad, I should have copied you, too. Thanks for having a look now.
> 
> any news on this?
> 
> Because it looks like I'll need the of_graph_get_port_by_id functionality in 
> the short term, it'll be nice to not having to opencode this :-)

Oh hell, you mean this still hasn't been merged for the next merge window?

What's going on, Grant?

Andrew, can you please take this if we send you the individual patches?
If not, I'll merge it into my tree, and send it to Linus myself.  If
Grant wakes up, we can address any comments he has at that time by
additional patches.  (I'll give Grant an extra few days to reply to
this mail...)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
