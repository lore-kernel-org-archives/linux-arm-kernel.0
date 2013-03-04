From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 4 Mar 2013 12:37:42 +0800
Subject: drivers/dma/dw_dmac.c:1278:48: sparse: incorrect type in argument
 1 (different base types)
In-Reply-To: <201303032051.28444.arnd@arndb.de>
References: <5133ae8b.eQXjkB7tQEqiUMck%fengguang.wu@intel.com>
 <201303032051.28444.arnd@arndb.de>
Message-ID: <CAOh2x=nEGOFbVgVKdNYNfaH_XPZYQ=aMrd076CFXj2_y54NogA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 4, 2013 at 4:51 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Subject: [PATCH] dmaengine: dw_dma: fix endianess for DT xlate function
>
> As reported by Wu Fengguang's build robot tracking sparse warnings, the
> dma_spec arguments in the dw_dma_xlate are already byte swapped on
> littl-endian platforms and must not get swapped again. This code is

s/littl/little

> currently not used anywhere, but will be used in Linux 3.10 when the
> ARM SPEAr platform starts using the generic DMA DT binding.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
