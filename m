From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 8 Oct 2018 14:30:09 +0800
Subject: [PATCH 06/36] dt-bindings: arm: zte: Move sysctrl bindings to
 their own doc
In-Reply-To: <20181005165848.3474-7-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-7-robh@kernel.org>
Message-ID: <20181008063007.GL3587@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2018 at 11:58:18AM -0500, Rob Herring wrote:
> In preparation to convert board-level bindings to json-schema, move
> various misc SoC bindings out to their own file.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Baoyou Xie <baoyou.xie@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/zte-sysctrl.txt   | 30 +++++++++++++++++++

zte,sysctrl.txt to be consistent with other files like
fsl,layerscape-dcfg.txt?  I'm fine with either way, but just want to
see more consistent naming convention?  Other than that,

Acked-by: Shawn Guo <shawnguo@kernel.org>
