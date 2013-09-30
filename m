From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Sep 2013 17:01:41 +0100
Subject: [PATCH 3/4] perf tools: Check libunwind for availability of
 dwarf parsing feature
In-Reply-To: <20130924171220.GB2634@ghostprotocols.net>
References: <1379323053-11458-1-git-send-email-jean.pihet@linaro.org>
 <1379323053-11458-4-git-send-email-jean.pihet@linaro.org>
 <20130917102904.GA27258@mudshark.cambridge.arm.com>
 <20130924171220.GB2634@ghostprotocols.net>
Message-ID: <20130930160141.GF26036@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaldo,

On Tue, Sep 24, 2013 at 06:12:20PM +0100, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 17, 2013 at 11:29:04AM +0100, Will Deacon escreveu:
> > Arnaldo, Ingo,
> > 
> > On Mon, Sep 16, 2013 at 10:17:32AM +0100, Jean Pihet wrote:
> > > The newly added dwarf unwinding feature [1] requires:
> > > . a recent version (>= 1.1) of libunwind,
> > > . libunwind to be configured with --enable-debug-frame.
> > > 
> > > [1] http://www.spinics.net/lists/kernel/msg1598951.html
> > > 
> > > Add the corresponding API test in the feature check list.
> > > 
> > > Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
> > > ---
> > >  tools/perf/config/Makefile          |  2 +-
> > >  tools/perf/config/feature-tests.mak | 11 ++++++++++-
> > >  2 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > Can I have an ack for this and the following patch please?
> > 
> > (http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/198531.html)
> > 
> > Then I can stick these into -next for some more exposure before I queue them
> > for 3.13.
> 
> I can pick it now that Jiri kinda acked it, right Jiri?

Jiri ended up acking v3 of the patches:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/200579.html

but I don't see them in -next. I'm happy to take them via my tree, just want
to make sure they don't conflict with anything you have planned for 3.13
and/or end up with our trees colliding in -next.

What's the plan?

Cheers,

Will
