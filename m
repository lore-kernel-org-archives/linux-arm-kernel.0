From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 07 Oct 2011 12:17:53 +0530
Subject: [PATCH 2/4] ARM: OMAP: Avoid cpu_is_omapxxxx usage until map_io
	is done
In-Reply-To: <20111005004542.26980.98554.stgit@kaulin.local>
References: <20111005004339.26980.31149.stgit@kaulin.local>
	<20111005004542.26980.98554.stgit@kaulin.local>
Message-ID: <4E8EA099.5020906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 October 2011 06:15 AM, Tony Lindgren wrote:
> This way we don't need to initialize SoC detection early
> and can start using generic map_io.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	
