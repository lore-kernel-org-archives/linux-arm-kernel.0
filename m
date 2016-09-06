From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2016 21:41:35 +0100
Subject: [PATCH] ARM: mmp: replace NO_IRQ
In-Reply-To: <4510913.a46LvNLeqZ@wuerfel>
References: <20160906140808.2883875-1-arnd@arndb.de>
 <6239709.hYdxF7WW9G@wuerfel>
 <20160906194443.GC1041@n2100.armlinux.org.uk>
 <4510913.a46LvNLeqZ@wuerfel>
Message-ID: <20160906204135.GE1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 10:19:18PM +0200, Arnd Bergmann wrote:
> The patch was correct, the only problem that you pointed out already
> was that it needs to be applied on top of your patch. I didn't
> check when the file was touched the last time but only looked at
> the current state in linux-next that happened to be from your
> patch last week.

The patch is not correct on its own - and, as far as I'm aware, my
patch to ucb1x00-core.c should not be in linux-next - it is part of
a series which is still - partly - a work-in-progress, and the patch
has dependencies on other changes in the series which are not obvious.

I see now that Lee has picked it up - that's just great, because it
does have a dependency on gpio changes.  That's _why_ it's part of
the large series.  Had Lee even bothered to read the fscking covering
message to the sub-series that he was covered on, he'd have realised
that he shouldn't have taken it yet.

The series was posted to get review comments and testing, not for
people to start cherry-picking patches from it as they damn-well
wish.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
