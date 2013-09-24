From: acme@ghostprotocols.net (Arnaldo Carvalho de Melo)
Date: Tue, 24 Sep 2013 14:12:20 -0300
Subject: [PATCH 3/4] perf tools: Check libunwind for availability of
 dwarf parsing feature
In-Reply-To: <20130917102904.GA27258@mudshark.cambridge.arm.com>
References: <1379323053-11458-1-git-send-email-jean.pihet@linaro.org>
 <1379323053-11458-4-git-send-email-jean.pihet@linaro.org>
 <20130917102904.GA27258@mudshark.cambridge.arm.com>
Message-ID: <20130924171220.GB2634@ghostprotocols.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, Sep 17, 2013 at 11:29:04AM +0100, Will Deacon escreveu:
> Arnaldo, Ingo,
> 
> On Mon, Sep 16, 2013 at 10:17:32AM +0100, Jean Pihet wrote:
> > The newly added dwarf unwinding feature [1] requires:
> > . a recent version (>= 1.1) of libunwind,
> > . libunwind to be configured with --enable-debug-frame.
> > 
> > [1] http://www.spinics.net/lists/kernel/msg1598951.html
> > 
> > Add the corresponding API test in the feature check list.
> > 
> > Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
> > ---
> >  tools/perf/config/Makefile          |  2 +-
> >  tools/perf/config/feature-tests.mak | 11 ++++++++++-
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> Can I have an ack for this and the following patch please?
> 
> (http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/198531.html)
> 
> Then I can stick these into -next for some more exposure before I queue them
> for 3.13.

I can pick it now that Jiri kinda acked it, right Jiri?

- Arnaldo
