From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Sep 2018 15:30:48 -0500
Subject: [PATCH v2 01/11] coresight: dts: binding: Fix example for TPIU
 component
In-Reply-To: <20180912135352.19722-2-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-2-suzuki.poulose@arm.com>
Message-ID: <20180926203048.GA24629@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Sep 2018 14:53:42 +0100, Suzuki K Poulose wrote:
> TPIU component has an input port. The example uses out-ports
> which is wrong. Let us fix it.
> 
> Reported-by: Leo Yan <leo.yan@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
