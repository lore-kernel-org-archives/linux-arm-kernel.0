From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 05 Oct 2011 09:45:28 +0300
Subject: [PATCH 3/4] ARM: OMAP: Remove calls to SRAM allocations for
	framebuffer
In-Reply-To: <20111005004544.26980.35612.stgit@kaulin.local>
References: <20111005004339.26980.31149.stgit@kaulin.local>
	<20111005004544.26980.35612.stgit@kaulin.local>
Message-ID: <1317797128.2631.2.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-10-04 at 17:45 -0700, Tony Lindgren wrote:
> This assumes fixed mappings which will not work once we move
> to use ioremap_exec(). It seems that these are currently
> not in use, or in use for some out of tree corner cases.
> 
> If SRAM support for framebuffer is wanted, it should be done
> with ioremap in the driver.
> 
> Note that further removal of the code can now be done,
> but that can be done seprately by the driver maintainers.
> 
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Looks good to me. I have similar changes in my working branch for omapfb
cleanup.

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi
