From: robh@kernel.org (Rob Herring)
Date: Fri, 16 Sep 2016 08:03:08 -0500
Subject: [PATCH v26 7/7] Documentation: dt: chosen properties for arm64
 kdump
In-Reply-To: <20160907043203.6309-1-takahiro.akashi@linaro.org>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <20160907043203.6309-1-takahiro.akashi@linaro.org>
Message-ID: <20160916130308.GA17955@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 01:32:03PM +0900, AKASHI Takahiro wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add documentation for
> 	linux,crashkernel-base and crashkernel-size,
> 	linux,elfcorehdr
> used by arm64 kexec/kdump to decribe the kdump reserved area, and
> the elfcorehdr's location within it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> [takahiro.akashi at linaro.org: added "linux,crashkernel-base" and "-size" ]
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  Documentation/devicetree/bindings/chosen.txt | 30 ++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
