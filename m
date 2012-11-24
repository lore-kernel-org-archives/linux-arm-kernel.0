From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 24 Nov 2012 11:34:13 +0530
Subject: [PATCH 5/6] ARM: OMAP4: MPUSS PM: remove unnecessary shim
 functions for powerdomain control
In-Reply-To: <20121124034237.24638.3621.stgit@dusk.lan>
References: <20121124033809.24638.11090.stgit@dusk.lan>
 <20121124034237.24638.3621.stgit@dusk.lan>
Message-ID: <50B0635D.2050700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 November 2012 09:12 AM, Paul Walmsley wrote:
> The OMAP4 MPU subsystem power management code contains several unnecessary
> shim functions for powerdomain control; remove them.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
Most of them are inline functions so final object code
will mostly same after and before the patch.
But cleaning these helpers is better I guess. So..

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
