From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 3 Oct 2011 11:36:26 +0100
Subject: [GIT PULL] Samsung devel-2 for v3.2
In-Reply-To: <005801cc817c$5d42f9e0$17c8eda0$%kim@samsung.com>
References: <002001cc80e5$3e497790$badc66b0$%kim@samsung.com>
	<20111002192950.GB1005@sirena.org.uk>
	<005801cc817c$5d42f9e0$17c8eda0$%kim@samsung.com>
Message-ID: <20111003103626.GA3731@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 12:27:22PM +0900, Kukjin Kim wrote:
> Mark Brown wrote:

> > As I reported the other day this change breaks the boot early on on the
> > Cragganmore S3C6410 based systems (I've not actually fired up my
> > SMDK6410 but I suspect it may have issues too).  I did make some brief
> > attempts to debug but as there's no console output at all and the diff
> > is rather large it's not easy to see what's gone wrong.

> Hmm, I thought it has no problem when I saw Thomas Abraham's 'serial:
> samsung' patches because he said it works fine with my for-next plus his
> patches on SMDK6410...Anyway, I need to sort it out.

It's possible it's something that doesn't manifest on that board, I've
no real idea what's exploding or why.  There's also a bunch of other
early boot problems right now like try_to_freeze() which aren't helping.
