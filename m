From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 8 Oct 2012 10:06:17 +0100
Subject: [PATCH] ARM: picoxcell: remove unnecessary header common.h
In-Reply-To: <1349432246-21795-1-git-send-email-tklauser@distanz.ch>
References: <1349432246-21795-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20121008090617.GA7589@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks good, thanks Tobias!

On Fri, Oct 05, 2012 at 12:17:26PM +0200, Tobias Klauser wrote:
> Since commit 66314223 ("ARM: socfpga: initial support for Altera's
> SOCFPGA platform") struct sys_timer dw_apb_timer is an extern in
> <linux/dw_apb_timer.h>, so there is no need for common.h anymore,
> instead directly #include <asm/mach/time.h> in common.c
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Acked-by: Jamie Iles <jamie@jamieiles.com>
