From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 May 2016 22:11:06 +0200
Subject: [PATCH 2/4] ARM: ux500: move ab8500_regulator_plat_data into
 driver
In-Reply-To: <20160510150822.GB6261@sirena.org.uk>
References: <1462888794-2793296-1-git-send-email-arnd@arndb.de>
 <1462888794-2793296-3-git-send-email-arnd@arndb.de>
 <20160510150822.GB6261@sirena.org.uk>
Message-ID: <3124394.oLWrYAHOyg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 May 2016 16:08:22 Mark Brown wrote:
> On Tue, May 10, 2016 at 03:59:48PM +0200, Arnd Bergmann wrote:
> > There is only one instance of ab8500_regulator_platform_data, and it's
> > safe to assume we won't ever merge another one, so it's rather pointless
> > to pass it through multiple levels of platform data pointers.
> 
> I'm missing patches 1 and 4 in this series.  What's going on, especially
> with regard to dependencies?

The four patches all have to be applied in order, I sent them to Linus (for
ux500) and Lee (for mtd) as a series to first have a look if the series
makes sense as a whole. You got added from get_maintainer.pl for two of
the patches that are in your domain.

I expect to have to either redo the series anyway, or have Linus pick it
up and forward it. If I resend, I'll add you to Cc for the whole series,
or I can bounce them to you if you like.

	Arnd
