From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 4 Oct 2011 13:59:17 +0100
Subject: [GIT PULL] Samsung devel-2 for v3.2
In-Reply-To: <019201cc8293$7776a790$6663f6b0$%kim@samsung.com>
References: <002001cc80e5$3e497790$badc66b0$%kim@samsung.com>
	<20111002192950.GB1005@sirena.org.uk>
	<019201cc8293$7776a790$6663f6b0$%kim@samsung.com>
Message-ID: <20111004125916.GC6934@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2011 at 09:45:16PM +0900, Kukjin Kim wrote:
> Mark Brown wrote:

> > As I reported the other day this change breaks the boot early on on the
> > Cragganmore S3C6410 based systems (I've not actually fired up my
> > SMDK6410 but I suspect it may have issues too).  I did make some brief
> > attempts to debug but as there's no console output at all and the diff
> > is rather large it's not easy to see what's gone wrong. 

> Could you please test on Cragganmore board again only with my for-next-test
> branch?

> (I have did 'git-revert' some patches which have some dependencies with
> other tree to build without others.)

Sure - it may be tomorrow morning (so late tomorrow your time) before
I'm sitting in front of a board for long enough to do it.
