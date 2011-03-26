From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Fri, 25 Mar 2011 19:44:20 -0500
Subject: [PATCH] OMAP3: l3: fix for "irq 10: nobody cared" message
In-Reply-To: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
References: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <AANLkTi=kPVAU5H_mddpKpTBOkr+UVAn-T=kS4iV0phwY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2011 at 7:29 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> If an error occurs in the L3 on any other initiator than MPU,
> the interrupt goes unhandled given that the 'base' register
> was calculated with the initialized err_base value (which

s/err_base/err_source/

> coincidentally points to MPU) and not with the actual source
> of the error.
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Regards,

Omar
