From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Oct 2018 13:24:35 -0500
Subject: [PATCH V7 1/3] dt-bindings: fsl: scu: make power domain
 compatible  string SoC specific
In-Reply-To: <1539883285-7990-2-git-send-email-aisheng.dong@nxp.com>
References: <1539883285-7990-1-git-send-email-aisheng.dong@nxp.com>
 <1539883285-7990-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181018182435.GA27382@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Oct 2018 17:25:57 +0000, "A.s. Dong" wrote:
> As the power domain API might change in the future for new SoCs, although
> in a very low possibility, it's still better to make the compatible string
> more SoC specific to avoid the possible version change for new SoCs.
> 
> Due to there're still no users in kernel, it's safe to update it without
> breaking anything.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v6->v7:
>  * keep "fsl,scu-pd" as fall back compatible string
> v5->v6:
>  * new patch
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
