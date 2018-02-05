From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:08:37 -0600
Subject: [PATCH v2 1/3] Documentation: dt-bindings: arm: Document kryo385
 cpu
In-Reply-To: <20180131161941.29865-2-rnayak@codeaurora.org>
References: <20180131161941.29865-1-rnayak@codeaurora.org>
 <20180131161941.29865-2-rnayak@codeaurora.org>
Message-ID: <20180205060837.m4wwnh3dhav75d5y@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 09:49:39PM +0530, Rajendra Nayak wrote:
> Document the compatible string for the Kryo385 cpus found in qualcomm
> SoCs.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>  1 file changed, 1 insertion(+)

"dt-bindings: arm: " for the subject prefix. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
