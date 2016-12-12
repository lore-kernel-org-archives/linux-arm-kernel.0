From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Dec 2016 11:25:11 -0600
Subject: [PATCH 2/4] dt-bindings: mfd: Remove TPS65217 interrupts
In-Reply-To: <20161209062833.5768-3-woogyom.kim@gmail.com>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
 <20161209062833.5768-3-woogyom.kim@gmail.com>
Message-ID: <20161212172511.5nj7whzytpkmrk7z@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 03:28:31PM +0900, Milo Kim wrote:
> Interrupt numbers are from the datasheet, so no need to keep them in
> the ABI. Use the number in the DT file.

I don't see the purpose of ripping this out. The headers have always 
been for convienence, not whether the values come from the datasheet or 
not.

> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi |  8 +++-----
>  include/dt-bindings/mfd/tps65217.h        | 26 --------------------------
>  2 files changed, 3 insertions(+), 31 deletions(-)
>  delete mode 100644 include/dt-bindings/mfd/tps65217.h
