From: philb@gnu.org (Phil Blundell)
Date: Sun, 11 Nov 2012 11:47:41 +0000
Subject: [PATCH 03/11] m68k: set arch_gettimeoffset directly
In-Reply-To: <1352408516-21988-5-git-send-email-swarren@wwwdotorg.org>
References: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org>
 <1352408516-21988-5-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1352634461.6869.106.camel@x121e.pbcl.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-11-08 at 14:01 -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> remove m68k's mach_gettimeoffset function pointer, and instead directly
> set the arch_gettimeoffset function pointer. This requires multiplying
> all function results by 1000, since the removed m68k_gettimeoffset() did
> this. Also, s/unsigned long/u32/ just to make the function prototypes
> exactly match that of arch_gettimeoffset.
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Philip Blundell <philb@gnu.org>

Acked-by: Phil Blundell <philb@gnu.org>

> Cc: Joshua Thompson <funaho@jurai.org>
> Cc: Sam Creasey <sammy@sammy.net>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
