From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Nov 2015 17:49:06 +0800
Subject: [PATCH] ARM: dts: vfxxx: Fix dspi[01] spi-num-chipselects.
In-Reply-To: <1447905280-5172-1-git-send-email-cory.tusar@pid1solutions.com>
References: <1447905280-5172-1-git-send-email-cory.tusar@pid1solutions.com>
Message-ID: <20151124094906.GW11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 10:54:39PM -0500, Cory Tusar wrote:
> Per the Vybrid Reference Manual (section 3.8.6.1), dspi0 has 6 chip
> select signals associated with it, while dspi1 has only 4.
> 
> Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>

Applied, thanks.
