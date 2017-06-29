From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Thu, 29 Jun 2017 08:57:57 -0500
Subject: [PATCH] EDAC: Get rid of mci->mod_ver
In-Reply-To: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
References: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
Message-ID: <deade91d-7326-8a39-3881-50db582c3098@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2017 05:03 AM, Borislav Petkov wrote:
> Hi,
> 
> any objections?
> 
> ---
> It is a write-only variable so get rid of it.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Thor Thayer <thor.thayer@linux.intel.com>
> Cc: Mark Gross <mark.gross@intel.com>
> Cc: Robert Richter <rric@kernel.org>
> Cc: Tim Small <tim@buttersideup.com>
> Cc: Ranganathan Desikan <ravi@jetztechnologies.com>
> Cc: "Arvind R." <arvino55@gmail.com>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Loc Ho <lho@apm.com>
> Cc: linux-edac at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mips at linux-mips.org
> ---
>   drivers/edac/altera_edac.c      | 2 --

<snip>

> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index db75d4b614f7..fa2e5db56d24 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -38,7 +38,6 @@
>   #include "edac_module.h"
>   
>   #define EDAC_MOD_STR		"altera_edac"
> -#define EDAC_VERSION		"1"
>   #define EDAC_DEVICE		"Altera"
>   

<snip>

Looks fine for Altera EDAC.

Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
