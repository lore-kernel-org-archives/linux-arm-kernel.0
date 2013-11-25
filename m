From: joelf@ti.com (Joel Fernandes)
Date: Mon, 25 Nov 2013 11:34:10 -0600
Subject: [PATCH v6] ARM: omap: edma: add suspend suspend/resume hooks
In-Reply-To: <1384726754-27875-1-git-send-email-zonque@gmail.com>
References: <1384726754-27875-1-git-send-email-zonque@gmail.com>
Message-ID: <52938A12.5030100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2013 04:19 PM, Daniel Mack wrote:
> This patch makes the edma driver resume correctly after suspend. Tested
> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
> 
> All information can be reconstructed by already known runtime
> information.
> 
> As we now use some functions that were previously only used from __init
> context, annotations had to be dropped.
> 
> [nm at ti.com: added error handling for runtime + suspend_late/early_resume]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Tested-by: Joel Fernandes <joelf@ti.com>
> Acked-by: Joel Fernandes <joelf@ti.com>

Hi Sekhar,

Can you consider pulling this patch? It has been tested and Acked. Thanks.

regards,

-Joel
