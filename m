From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 8 Mar 2013 16:50:22 -0500
Subject: [PATCH] arm: mvebu: enable the USB ports on Armada 370
 Reference Design board
In-Reply-To: <1362477304-22143-1-git-send-email-florian@openwrt.org>
References: <1362477304-22143-1-git-send-email-florian@openwrt.org>
Message-ID: <20130308215022.GT23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 10:55:04AM +0100, Florian Fainelli wrote:
> This patch modifies the Armada 370 Reference Design DTS file to enable
> support for the two USB ports found on this board.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Jason,
> 
> Since this board was added after USB support was added to Marvell
> Armada XP/370, I would appreciate if you could fold this into a
> pull request for 3.9-rc2 for instance.
> 
> Thanks!
> 
>  arch/arm/boot/dts/armada-370-rd.dts |    8 ++++++++
>  1 file changed, 8 insertions(+)

Please keep in mind that usually only fixes are applied to the -rcX's
for this window.  I've applied it this time because it is cleaning up a
DT conversion we already did, and it doesn't touch C code.

At any rate, applied to mvebu/fixes

thx,

Jason.
