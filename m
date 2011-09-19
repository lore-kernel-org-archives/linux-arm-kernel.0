From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2011 21:12:08 +0200
Subject: [PATCH] msm: platsmp: Mark ioremapped memory as __iomem
In-Reply-To: <1316454844-32733-1-git-send-email-sboyd@codeaurora.org>
References: <1316454844-32733-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <3623124.aFHn2mhMMC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 September 2011 10:54:04 Stephen Boyd wrote:
> Fixes a handful of sparse warnings.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/mach-msm/platsmp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Hi Stephen,

This looks good, and I've got a bunch of similar ones in
http://git.linaro.org/gitweb?p=people/arnd/linux.git;a=shortlog;h=refs/heads/randconfig
/msm

Maybe you or David could take a look at those and integrate
them. I was meaning to send them much earlier, but never
get around to actually make sure they are all good.

	arnd
