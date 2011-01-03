From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jan 2011 10:14:23 +0000
Subject: [PATCH 02/04] ARM i.MX25 Add SIM driver
In-Reply-To: <20736.212.121.242.58.1294045639.squirrel@mail.fqingenieria.es>
References: <20736.212.121.242.58.1294045639.squirrel@mail.fqingenieria.es>
Message-ID: <20110103101423.GC26785@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 03, 2011 at 10:07:19AM +0100, FQ | Iban Cerro wrote:
>  arch/arm/plat-mxc/Kconfig                |    7 +
>  arch/arm/plat-mxc/Makefile               |    1 +
>  arch/arm/plat-mxc/include/mach/mxc_sim.h |  319 +++++++++++
>  arch/arm/plat-mxc/sim.c                  |  874
> ++++++++++++++++++++++++++++++

Please find somewhere under drivers/ to put... drivers.  Not in arch/
thanks.
