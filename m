From: tony@atomide.com (Tony Lindgren)
Date: Fri, 5 Nov 2010 14:49:17 -0700
Subject: [PATCHv2 0/3] Various code improvements for IGEP v2 board.
In-Reply-To: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
References: <1287852540-4951-1-git-send-email-eballetbo@gmail.com>
Message-ID: <20101105214917.GZ9264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enric Balletbo i Serra <eballetbo@gmail.com> [101023 09:40]:
> 
> Hello,
> 
> The comments of this post also apply to IGEP v2 board (thanks Laurent)
> 
>   http://www.mail-archive.com/linux-omap at vger.kernel.org/msg36402.html
> 
> Changes since v1:
>  - Split patch in a serie.
>  - [1/3] onenand_setup = NULL, is a static variable, removed from code.
> 
> This patch apply on top of tmlind/omap-for-linux branch.
> 
> $ git diff --stat tmlind/omap-for-linus 
>  arch/arm/mach-omap2/board-igep0020.c |   35 ++++++++++-----------------------
>  1 files changed, 11 insertions(+), 24 deletions(-)

Thanks, I'll queue these for 2.6.38 merge window.

Regards,

Tony
