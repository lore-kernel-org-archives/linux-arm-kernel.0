From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 12 Jan 2012 20:26:34 +0100
Subject: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap
 changes
In-Reply-To: <20120112184256.GA2287@atomide.com>
References: <20120112184256.GA2287@atomide.com>
Message-ID: <CAMQu2gx-629ukSTgd=ngQiAeEnBT1+H1racDC_tu_RO7mZjdfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 7:42 PM, Tony Lindgren <tony@atomide.com> wrote:
> Commit 73829af71fdb8655e7ba4b5a2a6612ad34a75a11
> (Merge branch 'vmalloc' of git://git.linaro.org/people/nico/linux
> into devel-stable) merged generic ioremap changes.
>
> Commit 137d105d50f6e6c373c1aa759f59045e6239cf66
> (ARM: OMAP4: Fix errata i688 with MPU interconnect barriers)
> added a workaround for omap4.
>
> In order for the errata to work, we now need the following
> patch or else we'll get:
>
> kernel BUG at mm/vmalloc.c:1134!
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
Thanks Tony.

Looks good to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
