From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Nov 2018 10:46:16 +0800
Subject: [PATCH] ARM: dts: imx6q-bx50v3: user-space watchdog GPIO
 configuration
In-Reply-To: <12f6a6d21202bf6622bda94df6f8029cbde6c0bc.1541312342.git.ian.ray@ge.com>
References: <12f6a6d21202bf6622bda94df6f8029cbde6c0bc.1541312342.git.ian.ray@ge.com>
Message-ID: <20181116024615.GC5829@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 04, 2018 at 08:19:38AM +0200, Ian Ray wrote:
> Leave b{4,6}50v3 GPIO expander pca953x pins P05,P10,P11 unconfigured as
> they are now used to implement an additional watchdog mechanism in user
> space.  P10,P11 pins remain unused (and therefore hogged) on b850v3.
> 
> Signed-off-by: Ian Ray <ian.ray@ge.com>

Applied, thanks.
