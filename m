From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 13:44:17 -0400
Subject: [PATCH] ARM: plat-orion: Fix num_resources and id for ge10 and
 ge11
In-Reply-To: <1368994363-14762-1-git-send-email-gregory.clement@free-electrons.com>
References: <1368994363-14762-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130520174417.GZ31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 19, 2013 at 10:12:43PM +0200, Gregory CLEMENT wrote:
> When platform data were moved from arch/arm/mach-mv78xx0/common.c to
> arch/arm/plat-orion/common.c with the commit "7e3819d ARM: orion:
> Consolidate ethernet platform data", there were few typo made on
> gigabit Ethernet interface ge10 and ge11. This commit writes back
> their initial value, which allows to use this interfaces again.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/plat-orion/common.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied to mvebu/fixes and marked for stable back to v3.0.x

thx,

Jason.
