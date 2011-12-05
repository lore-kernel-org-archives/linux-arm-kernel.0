From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Dec 2011 14:30:40 +0000
Subject: [PATCH 0/6] arm/imx: kill macro MXC_GPIO_IRQ_START
In-Reply-To: <20111205080351.GV27267@pengutronix.de>
References: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
 <20111205080351.GV27267@pengutronix.de>
Message-ID: <201112051430.40737.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 December 2011, Sascha Hauer wrote:
> > 
> > Please let me know if you would send the series through -rc.  If you
> > do, that's great.  If you do not, that's fine, since it touches many
> > files and looks more like a cleanup work, and I will send your the
> > above quick/temporary fixing for -rc, and then rebase this series on
> > top of it and send for v3.3.
> 
> As you touch many boards which you can't test I don't think this stuff
> is suitable for -rc. Otherwise I'm fine with this series.
> 

Agreed. It seems fine to go into next but I wouldn't send this
as bug fixes for 3.2.

	Arnd
