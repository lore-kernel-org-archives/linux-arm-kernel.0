From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 11 Feb 2014 14:34:26 -0500
Subject: [PATCH 1/3] ARM: mvebu: remove unneeded ->map_io field for
 Armada 370/XP
In-Reply-To: <1392138433-12573-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392138433-12573-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392138433-12573-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140211193426.GI27395@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 06:07:11PM +0100, Thomas Petazzoni wrote:
> The ->map_io() implementation of Armada 370/XP simply calls
> debug_ll_io_init(), which is exactly what the kernel does when
> ->map_io is NULL. Therefore, there is no need to have a specific
> ->map_io() implementation in Armada 370/XP.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/armada-370-xp.c | 6 ------
>  1 file changed, 6 deletions(-)

Applied to mvebu/soc with Gregory's Ack.

thx,

Jason.
