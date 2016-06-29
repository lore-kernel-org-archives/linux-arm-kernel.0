From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 29 Jun 2016 11:23:21 +0200
Subject: [PATCH 4/7] reset: Supply *_shared variant calls when using
 *_optional APIs
In-Reply-To: <20160629080611.GH29166@dell>
References: <20160606155655.10860-1-lee.jones@linaro.org>
 <20160606155655.10860-5-lee.jones@linaro.org> <20160628085622.GM6720@dell>
 <1467186499.2278.7.camel@pengutronix.de> <20160629080611.GH29166@dell>
Message-ID: <1467192201.2278.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 29.06.2016, 09:06 +0100 schrieb Lee Jones:
> On Wed, 29 Jun 2016, Philipp Zabel wrote:
> > Am Dienstag, den 28.06.2016, 09:56 +0100 schrieb Lee Jones:
> > > Philipp,
> > > 
> > > I need this to go into the -rcs too.
> > > 
> > > Can I add it with your Ack please?
> > 
> > I have already added your patches to my branch, and I intend to send a
> > pull request for it tomorrow. I am afraid applying this patch in another
> > branch would create a merge conflict with
> > git://git.pengutronix.de/git/pza/linux.git reset/next
> > in arm-soc. If that is not the case, go ahead. Otherwise I could provide
> > a tag at commit 2485394d9e0b ("reset: TRIVIAL: Add line break at same
> > place for similar APIs") for you to merge.
> 
> Yes please.  If you could tag a branch containing commit:
> 
>   reset: Supply *_shared variant calls when using *_optional APIs
> 
> ... that would be perfect.  Would you mind sending me the tag name
> ASAP please, since I am ready to send my pull-request to Linus.

git://git.pengutronix.de/git/pza/linux.git tags/reset-shared-optional

regards
Philipp
