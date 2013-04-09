From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 17:57:08 +0200
Subject: [GIT PULL 4/4] ARM: mxs: device tree changes for 3.10
In-Reply-To: <1365411621-18422-4-git-send-email-shawn.guo@linaro.org>
References: <1365411621-18422-1-git-send-email-shawn.guo@linaro.org>
 <1365411621-18422-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <201304091757.08475.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Shawn Guo wrote:
> Hi Arnd, Olof,
> 
> This is the mxs device tree changes for 3.10.  It's based on
> mxs-cleanup-3.10 to avoid some nasty conflicts.  Please pull, thanks.
> 
> Shawn
> 
> The following changes since commit e933a1a12a02f42e0013cda87bba37ccb59efc47:
> 
>   clocksource: mxs_timer: Add semicolon at end of line (2013-04-03 10:30:08 +0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-dt-3.10
> 
> for you to fetch changes up to 4344429d3d926d219671f607125cff51223a140a:
> 
>   video: mxsfb: Introduce regulator support (2013-04-08 15:44:55 +0800)
> 
> ----------------------------------------------------------------
> The mxs device tree changes for 3.10:
> 
> * Move enet_out clk into device tree and have fec driver handle it.
> * Convert mxsfb driver to generic display timings bindings, and remove
>   the mxsfb auxdata from platform code.
> * Add generic DMA device tree binding for mxs-dma, and convert the most
>   of client device drivers to it.
> * Change mxsfb driver to use regulator for controlling power of panel.
> * A few device tree source updates

Pulled into next/dt2, thanks!

	Arnd
