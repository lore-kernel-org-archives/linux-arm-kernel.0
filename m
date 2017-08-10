From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 09:01:57 -0500
Subject: [PATCH v2 3/4] dt-bindings: remoteproc: Add bindings for Davinci
 DSP processors
In-Reply-To: <20170801154844.24662-4-s-anna@ti.com>
References: <20170801154844.24662-1-s-anna@ti.com>
 <20170801154844.24662-4-s-anna@ti.com>
Message-ID: <20170810140157.osn5rtymykgdf6gp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 10:48:43AM -0500, Suman Anna wrote:
> Add the device tree bindings document for the DSP processor
> subsystem devices on TI Davinci DA8xx/OMAP-L13x SoCs.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v2: 
>  - Updated the patch header
>  - Revised the binding status statement slightly
>  - Updated the example to address Rob's comments
>  - No changes in properties description themselves
> v1: https://patchwork.kernel.org/patch/9751269/
> 
>  .../bindings/remoteproc/ti,davinci-rproc.txt       | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt

Acked-by: Rob Herring <robh@kernel.org>
