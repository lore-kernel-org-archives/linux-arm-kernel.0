From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 10:13:28 -0500
Subject: [PATCH v2 3/4] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <1360155984-15397-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360155984-15397-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130216151328.GT14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 10:06:23AM -0300, Ezequiel Garcia wrote:
> This patch adds an SPI master device node for Armada XP-GP board.
> This master node is an SPI flash controller 'n25q128a13'.
> 
> Since there is no 'partitions' node declared, one full sized
> partition named as the device will be created.
> 
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Lior Amsalem <alior@marvell.com>
> Tested-by: Gregory Clement <gregory.clement@free-electrons.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Depends on Gregory's patch for Armada XP GP board:
> "arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)"
> 
>  arch/arm/boot/dts/armada-xp-gp.dts |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)

Applied to mvebu/dt

thx,

Jason.
