From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 24 Mar 2015 22:03:20 +0900
Subject: [PATCH] ARM: S3C64XX: Use fixed IRQ bases to avoid conflicts on
 Cragganmore
In-Reply-To: <20150322160316.GB6643@sirena.org.uk>
References: <1427020841-24189-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20150322160316.GB6643@sirena.org.uk>
Message-ID: <02e801d06632$e75527e0$b5ff77a0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Sun, Mar 22, 2015 at 10:40:41AM +0000, Charles Keepax wrote:
> > There are two PMICs on Cragganmore, currently one dynamically assign
> > its IRQ base and the other uses a fixed base. It is possible for the
> > statically assigned PMIC to fail if its IRQ is taken by the dynamically
> > assigned one. Fix this by statically assigning both the IRQ bases.
> >
> > Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> 
> Reviwed-by: Mark Brown <broonie@kernel.org>
> 
Thanks for your review.

> This probably wants to go to stable as well.

OK, I'll.

Thanks,
Kukjin
