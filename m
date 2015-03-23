From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 23 Mar 2015 17:29:02 +0100
Subject: [GIT PULL v2] of: Add of-graph helpers to loop over endpoints and
 find ports by id
In-Reply-To: <1426063881.3101.33.camel@pengutronix.de>
References: <1425369592.3146.14.camel@pengutronix.de>
 <CAL_Jsq+s5RN+7z8Q5N1VghxaQ_ajQmBddtWOTovLoVJjb_6uDw@mail.gmail.com>
 <1426063881.3101.33.camel@pengutronix.de>
Message-ID: <2376013.jScnaqPlDa@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob, Philipp,

Am Mittwoch, 11. M?rz 2015, 09:51:21 schrieb Philipp Zabel:
> Am Dienstag, den 10.03.2015, 14:05 -0500 schrieb Rob Herring:
> > I've only been copied on this latest pull request and a version from
> > March of last year which Grant nak'ed. This series did not go to
> > devicetree list either. I'll take a look at the series.
> 
> My bad, I should have copied you, too. Thanks for having a look now.

any news on this?

Because it looks like I'll need the of_graph_get_port_by_id functionality in 
the short term, it'll be nice to not having to opencode this :-)


Thanks
Heiko

> 
> The nak'ed series (https://lkml.org/lkml/2014/3/20/664) indeed already
> included the "of: Add OF graph helper to get a specific port by id" and
> "of: Add OF graph helpers to iterate over ports" patches, but Grant's
> nak applied to the first patch, "of: Parse OF graph into graph
> structure", which I then dropped.
> 
> > If there is an explanation of how Grant's nak was addressed that would
> > speed up my review.
> 
> See above. The other two patches have been uncontroversial. The
> of_graph_get_next_endpoint and for_each_endpoint_of_node patches
> fix an in-kernel API that was too easy to use incorrectly, and
> the of_graph_get_port_by_id patch I can't remember being
> commented on at all.
> 
> > I'm not applying for v4.0 though.
> 
> If you decide to apply them, please consider merging the tag and giving
> your ack for it to be merged into the other subsystem trees, too.
> 
> regards
> Philipp
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
