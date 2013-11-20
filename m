From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Nov 2013 09:51:07 -0500
Subject: [PATCH] clk: keystone: gate: fix error handling on init
In-Reply-To: <1384949341-26486-1-git-send-email-grygorii.strashko@ti.com>
References: <1384949341-26486-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <528CCC5B.4010204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 November 2013 07:09 AM, Grygorii Strashko wrote:
> This patch fixes Keystone gate control clock driver initialization path:
> 1) clk_register_psc() returns error code and not a pure pointer, hence
> its return value need to be checked using IS_ERR(clk) macro.
> 
> 2) Mapped IO memory isn't unmapped in case of errors, hence fix it.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
Looks good. Thanks !!

Mike, If you are ok can you please consider it for fixes ?

Regards,
Santosh
