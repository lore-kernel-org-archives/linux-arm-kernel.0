From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Dec 2010 10:28:22 +0100
Subject: [PATCH] add clock debug information for imx51 babbage
In-Reply-To: <AANLkTi=cTYjaDh0Zd-7joLCycMcLoPW+Ekws=46QMoDc@mail.gmail.com>
References: <AANLkTi=cTYjaDh0Zd-7joLCycMcLoPW+Ekws=46QMoDc@mail.gmail.com>
Message-ID: <20101202092822.GN32355@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Dec 01, 2010 at 07:30:54PM +0800, Yong Shen wrote:
> Hi there,
> 
> This patch makes BSP development easier, since it displays the whole
> clock information in tree-like manner. The final goal is to make it a
> part of common clock framework, but so far this goal depends on other
> unfinished work.
BTW, I would prefer to have this on top of the generic clkdev patches
(see http://thread.gmane.org/gmane.linux.ports.arm.kernel/90225)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
