From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Mar 2012 11:26:19 -0400 (EDT)
Subject: [PATCH v3 2/5] ARM: Add a printk loglevel modifier
In-Reply-To: <1331720516-11801-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120314101928.GA29474@pengutronix.de>
 <1331720516-11801-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1203141125120.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Mar 2012, Uwe Kleine-K?nig wrote:

> This is a needed followup for
> 
> 	ARM: protect usage of cr_alignment by #ifdef CONFIG_CPU_CP15
> 
> otherwise no newline is printed for !CONFIG_CPU_CP15
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Should this be folded into the
> 
> 	ARM: protect usage of cr_alignment by #ifdef CONFIG_CPU_CP15
> 
> patch? Or should it come before it?

Given my comments on that other patch, this one could be dropped 
altogether.


Nicolas
