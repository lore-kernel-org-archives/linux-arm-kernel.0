From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jun 2018 14:46:12 -0600
Subject: [PATCH v2 4/6] dts: bindings: Document device tree binding for
 CATU
In-Reply-To: <20180625112213.23492-5-suzuki.poulose@arm.com>
References: <20180625112213.23492-1-suzuki.poulose@arm.com>
 <20180625112213.23492-5-suzuki.poulose@arm.com>
Message-ID: <20180625204612.GA15054@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 12:22:11PM +0100, Suzuki K Poulose wrote:
> Document CATU device-tree bindings. CATU augments the TMC-ETR
> by providing an improved Scatter Gather mechanism for streaming
> trace data to non-contiguous system RAM pages.
> 
> Cc: devicetree at vger.kernel.org
> Cc: frowand.list at gmail.com
> Cc: Rob Herring <robh@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../devicetree/bindings/arm/coresight.txt          | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
