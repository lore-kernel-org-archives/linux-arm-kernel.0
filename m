From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 29 Jun 2017 12:29:16 +0200
Subject: [PATCH] EDAC: Get rid of mci->mod_ver
In-Reply-To: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
References: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
Message-ID: <36769669-866d-8bb1-a9ac-399ed56066bf@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.6.2017 12:03, Borislav Petkov wrote:
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
>  drivers/edac/altera_edac.c      | 2 --
>  drivers/edac/amd64_edac.c       | 1 -
>  drivers/edac/amd76x_edac.c      | 2 --
>  drivers/edac/cpc925_edac.c      | 1 -
>  drivers/edac/e752x_edac.c       | 2 --
>  drivers/edac/e7xxx_edac.c       | 2 --
>  drivers/edac/ghes_edac.c        | 3 ---
>  drivers/edac/highbank_mc_edac.c | 1 -
>  drivers/edac/i3000_edac.c       | 3 ---
>  drivers/edac/i3200_edac.c       | 3 ---
>  drivers/edac/i5000_edac.c       | 1 -
>  drivers/edac/i5100_edac.c       | 1 -
>  drivers/edac/i5400_edac.c       | 1 -
>  drivers/edac/i7300_edac.c       | 1 -
>  drivers/edac/i7core_edac.c      | 1 -
>  drivers/edac/i82443bxgx_edac.c  | 3 ---
>  drivers/edac/i82860_edac.c      | 2 --
>  drivers/edac/i82875p_edac.c     | 2 --
>  drivers/edac/i82975x_edac.c     | 2 --
>  drivers/edac/ie31200_edac.c     | 2 --
>  drivers/edac/mv64x60_edac.c     | 1 -
>  drivers/edac/ppc4xx_edac.c      | 1 -
>  drivers/edac/r82600_edac.c      | 2 --
>  drivers/edac/sb_edac.c          | 1 -
>  drivers/edac/skx_edac.c         | 3 ---
>  drivers/edac/synopsys_edac.c    | 1 -

No problem with this change.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
