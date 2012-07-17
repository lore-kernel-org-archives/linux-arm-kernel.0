From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 20:46:20 +0000
Subject: [GIT PULL] i.MX clk fixes and updates
In-Reply-To: <20120717072833.GZ30009@pengutronix.de>
References: <20120717072833.GZ30009@pengutronix.de>
Message-ID: <201207172046.20783.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012, Sascha Hauer wrote:
> Hi Arnd, Olof,
> 
> Please pull the following i.MX clk fixes and updates for next. Not
> strictly divided into fixes/features, but all around clk support, hope
> that's ok.

Yes, that's all good. I've appled it to the next/clk branch that
I already have for other clock related changes.

If you are in a similar situation next time, you can also order the
patches so that the bug fixes come first so I can apply the patches
at the bottom to the fixes-non-critical branch in addition to the
topic branch. If you prefer not to rebase the series though, it's
also ok to send a topic like this.

	Arnd
