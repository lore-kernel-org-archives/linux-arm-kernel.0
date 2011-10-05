From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 6 Oct 2011 00:05:17 +0100
Subject: [GIT PULL] Samsung devel-2 for v3.2
In-Reply-To: <20111005165401.GA7155@opensource.wolfsonmicro.com>
References: <002001cc80e5$3e497790$badc66b0$%kim@samsung.com>
	<20111002192950.GB1005@sirena.org.uk>
	<019201cc8293$7776a790$6663f6b0$%kim@samsung.com>
	<20111005165401.GA7155@opensource.wolfsonmicro.com>
Message-ID: <20111005230516.GA30439@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2011 at 05:54:02PM +0100, Mark Brown wrote:
> On Tue, Oct 04, 2011 at 09:45:16PM +0900, Kukjin Kim wrote:

> > Could you please test on Cragganmore board again only with my for-next-test
> > branch?

> I tried this, same result as -next.  v3.1-rc8 works fine.  I also tried
> a bisect which was a bit of a nightmare due to soc_is_ and S5P_VA_GPIOn
> not being defined in the GPIO code and other places in a lot of
> revisions so I didn't finish it, perhaps later.

I also meant to say that I tried printascii() also and it didn't seem to
produce any additional logging.  I'll complete the bisect and poke a bit
more tomorrow.
