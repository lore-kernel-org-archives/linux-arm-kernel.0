From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Jul 2014 04:05:53 -0700
Subject: [PATCH v4 01/11] ARM: omap: edma: add suspend suspend/resume hooks
In-Reply-To: <1405047349-15101-2-git-send-email-d-gerlach@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
 <1405047349-15101-2-git-send-email-d-gerlach@ti.com>
Message-ID: <20140714110552.GA20068@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [140710 19:58]:
> From: Daniel Mack <zonque@gmail.com>
> 
> This patch makes the edma driver resume correctly after suspend. Tested
> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
> 
> All information can be reconstructed by already known runtime
> information.
> 
> As we now use some functions that were previously only used from __init
> context, annotations had to be dropped.

This is something Sekhar needs to look at, did you maybe forget
to Cc him?

Regards,

Tony
