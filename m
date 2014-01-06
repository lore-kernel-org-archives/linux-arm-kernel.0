From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Jan 2014 17:01:59 +0900
Subject: [PATCH 3/4] ARM: shmobile: Remove duplicate
 shmobile_invalidate_start() declaration
In-Reply-To: <1388764128-27686-3-git-send-email-geert@linux-m68k.org>
References: <1388764128-27686-1-git-send-email-geert@linux-m68k.org>
 <1388764128-27686-3-git-send-email-geert@linux-m68k.org>
Message-ID: <20140106080159.GQ24653@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 04:48:47PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> ---
>  arch/arm/mach-shmobile/include/mach/common.h |    1 -
>  1 file changed, 1 deletion(-)

Thanks, I will queue this up.
