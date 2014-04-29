From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Apr 2014 13:16:08 +0200
Subject: [PATCH v4 4/5] ARM: OMAP2+: Add machine entry for dra72x devices
In-Reply-To: <1398769513-8736-5-git-send-email-rnayak@ti.com>
References: <1398769513-8736-1-git-send-email-rnayak@ti.com>
 <1398769513-8736-5-git-send-email-rnayak@ti.com>
Message-ID: <4370878.HUQMK8VpUE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 April 2014 16:35:12 Rajendra Nayak wrote:
> The only difference from the dra74x devices is the missing .smp entry.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/board-generic.c |   25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
