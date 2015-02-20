From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 20 Feb 2015 14:05:49 +0100
Subject: [PATCH 08/10] ARM: mvebu: add core support for Armada 39x
In-Reply-To: <54D51CC6.2070908@codeaurora.org>
References: <1423238276-9206-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1423238276-9206-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <54D51CC6.2070908@codeaurora.org>
Message-ID: <20150220140549.2a2d4336@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stephen Boyd,

On Fri, 06 Feb 2015 11:57:58 -0800, Stephen Boyd wrote:

> > +static const char * const armada_39x_dt_compat[] = {
> 
>  __initconst?

Good idea. This wasn't done for the other mach-mvebu dt_compat tables,
so I've added a patch to do this as well for the other mach-mvebu
dt_compat tables.

Will be in v2.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
