From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2016 00:40:32 +0200
Subject: [GIT PULL 2/4] soc/tegra: Changes for v4.9-rc1
In-Reply-To: <9462882.Qh35FHRZfK@wuerfel>
References: <20160909152032.9550-1-thierry.reding@gmail.com>
 <20160909152032.9550-2-thierry.reding@gmail.com> <9462882.Qh35FHRZfK@wuerfel>
Message-ID: <5777274.tbFdIa53BH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 15, 2016 12:32:04 AM CEST Arnd Bergmann wrote:
> On Friday, September 9, 2016 5:20:30 PM CEST Thierry Reding wrote:
> > soc/tegra: Changes for v4.9-rc1
> > 
> > This contains a single patch to fix an issue with setting the deep power
> > down mode of I/O rails.
> > 
> 
> Pulled into next/soc. 

I made up my mind and put it into next/drivers instead of next/soc.

	Arnd

> Should this be backported to stable kernels?
