From: robh@kernel.org (Rob Herring)
Date: Fri, 19 May 2017 20:45:54 -0500
Subject: [PATCH v2 1/2] Documentation: dt: Update ti,emif bindings
In-Reply-To: <20170519175708.6070-2-d-gerlach@ti.com>
References: <20170519175708.6070-1-d-gerlach@ti.com>
 <20170519175708.6070-2-d-gerlach@ti.com>
Message-ID: <20170520014554.qisnvr27542n5p7f@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 12:57:07PM -0500, Dave Gerlach wrote:
> Update the Texas Instruments EMIF binding document to include the device
> tree bindings for ti,emif-am3352 and ti,emif-am4372 which are used by
> the ti-emif-sram driver to provide low-level PM functionality.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  .../devicetree/bindings/memory-controllers/ti/emif.txt | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

I acked v1. Please add acks when posting new versions.

Rob
