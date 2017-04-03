From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Apr 2017 09:34:59 -0500
Subject: [PATCH 1/2] Documentation: dt: Update ti,emif bindings
In-Reply-To: <20170328205511.21166-2-d-gerlach@ti.com>
References: <20170328205511.21166-1-d-gerlach@ti.com>
 <20170328205511.21166-2-d-gerlach@ti.com>
Message-ID: <20170403143459.ligq2bphu3n6zvkl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 03:55:10PM -0500, Dave Gerlach wrote:
> Update the Texas Instruments EMIF binding document to include the device
> tree bindings for ti,emif-am3352 and ti,emif-am4372 which are used by
> the ti-emif-sram driver to provide low-level PM functionality.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  .../devicetree/bindings/memory-controllers/ti/emif.txt | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
