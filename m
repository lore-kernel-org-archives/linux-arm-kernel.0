From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 17 Sep 2014 11:03:19 -0400
Subject: [PATCH] ARM: mvebu: switch the Armada 370 RD board to internal
 registers at 0xf1000000
In-Reply-To: <1410961539-10388-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1410961539-10388-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140917150319.GD16945@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 03:45:39PM +0200, Thomas Petazzoni wrote:
> Recent bootloader versions from Marvell that have DT support and
> various other new features remap the internal registers at
> 0xf1000000. We have already done this change for most of the
> development boards from Marvell, and this commit does this change for
> the Marvell Armada 370 RD board.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-rd.dts | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Applied to mvebu/dt

thx,

Jason.
