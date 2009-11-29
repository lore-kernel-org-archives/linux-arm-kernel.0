From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sun, 29 Nov 2009 15:33:19 +0530
Subject: [PATCH 0/8] Series short description
In-Reply-To: <20091126001646.1546.34352.stgit@localhost>
References: <20091126001646.1546.34352.stgit@localhost>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BBE6475D@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Thursday, November 26, 2009 5:49 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org
> Subject: [PATCH 0/8] Series short description
> 
> Hi all,
> 
> Here are some omap mux updates for review. These
> are intended for the v2.6.33 merge window.
> 
> Initially this series changes the omap34xx mux
> code, I'm planning on adding 3630, 2420, and 2430
> code later on.
> 
> There are several reasons why we need better mux
> code:
> 
> - We want to make the mux code more generic and this
>   will allow us to use the internal signal names and
>   gpio numbers instead of mux register offsets. The
>   internal signal names stay the same across omap
>   generations for some devices.
> 
> - We need to map mux registers to GPIO registers for
>   dynamic muxing of the GPIO pins during off-idle.
> 
> - We want to be able to override the bootloader mux
>   values for the modded boards, such as the Beagle.
> 
> - We want to have the mux signals and balls available
>   under debugfs for debugging new drivers.
> 
> Some of these might eventually work for other archs
> too, so let me know if you have any comments on that.

Thanks for the series. Managing mux is always an issue and most time consuming one. This series will improve mux code greatly.

Regards,
Santosh
 
