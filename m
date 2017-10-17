From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Oct 2017 07:59:02 -0700
Subject: SPI regression in today's Linux next
In-Reply-To: <20171017144021.r7aydswer7anb5ha@sirena.co.uk>
References: <20171017143454.GA4394@atomide.com>
 <20171017144021.r7aydswer7anb5ha@sirena.co.uk>
Message-ID: <20171017145901.GB4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@kernel.org> [171017 07:41]:
> On Tue, Oct 17, 2017 at 07:34:54AM -0700, Tony Lindgren wrote:
> > Hi Lucas and Mark,
> > 
> > Looks like commit 9ce70d49fa80 ("spi: fix IDR collision on systems with
> > both fixed and dynamic SPI bus numbers") causes the following regression
> > at least for omaps. Reverting commit 9ce70d49fa80 fixes it.
> > 
> > Any ideas?
> 
> There's a fix already.

OK so with next-20171016, revert 9ce70d49fa80 and pick
226584aedd from the spi.git tree. Seems to work for me.

Thanks,

Tony
