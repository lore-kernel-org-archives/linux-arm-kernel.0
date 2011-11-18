From: khilman@ti.com (Kevin Hilman)
Date: Fri, 18 Nov 2011 10:39:41 -0800
Subject: [PATCH 07/23] ARM: plat-omap: remove arch specific special
 handling for ioremap
In-Reply-To: <1321422521-1138-8-git-send-email-nico@fluxnic.net> (Nicolas
 Pitre's message of "Wed, 16 Nov 2011 00:48:25 -0500")
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
 <1321422521-1138-8-git-send-email-nico@fluxnic.net>
Message-ID: <87ty61xok2.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre <nico@fluxnic.net> writes:

> From: Nicolas Pitre <nicolas.pitre@linaro.org>
>
> A generic version should replace this later.
>
> As io.c has become nearly empty, omap_init_consistent_dma_size() is moved
> into common.c so that io.c can be removed entirely.
>
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Boot tested on OMAP3430/n900, OMAP3530/Overo, OMAP3630/Zoom3,
OMAP4430/Panda

Tested-by: Kevin Hilman <khilman@ti.com>

Kevin
