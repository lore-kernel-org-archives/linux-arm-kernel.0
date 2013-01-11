From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 Jan 2013 13:54:44 +0800
Subject: [PATCH 3/3] ARM: samsung: remove unused arch_decomp_wdog() code
In-Reply-To: <041c01cdefbf$c46fddb0$4d4f9910$@samsung.com>
References: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
 <1357827165-9320-4-git-send-email-shawn.guo@linaro.org>
 <041c01cdefbf$c46fddb0$4d4f9910$@samsung.com>
Message-ID: <20130111055442.GA12579@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 09:51:55PM -0800, Kukjin Kim wrote:
> Shawn Guo wrote:
> > 
> > With ARCH_HAS_DECOMP_WDOG removed from
> > arch/arm/boot/compressed/decompress.c,
> > all the arch_decomp_wdog() related codes become unused.  Remove them.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> 
> Looks good to me,
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
Thanks, Kim.

> Do you want me to take this into Samsung tree?
> 
I would like to send them as a series to arm-soc.

Shawn
