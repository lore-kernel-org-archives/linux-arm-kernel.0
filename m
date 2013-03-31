From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 31 Mar 2013 17:14:12 -0400
Subject: [PATCH 1/2] Fix typo in the definition of rebuild LED pins for
 ix2-200
In-Reply-To: <1364703204-14982-2-git-send-email-nigel@nobiscuit.com>
References: <1364703204-14982-1-git-send-email-nigel@nobiscuit.com>
 <1364703204-14982-2-git-send-email-nigel@nobiscuit.com>
Message-ID: <20130331211412.GL13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 31, 2013 at 03:13:23PM +1100, Nigel Roberts wrote:
> ---
>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Ahhh, it looks like the conversion to pinctrl did this.  The original
patch adding support for this board:

  4f48b7f ARM: Kirkwood: Iomega ix2-200 DT support

has the pins set as you describe.

thx,

Jason.
