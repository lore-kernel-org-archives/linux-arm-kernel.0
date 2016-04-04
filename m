From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Apr 2016 00:15:52 -0500
Subject: [v7, 3/5] dt: move guts devicetree doc out of powerpc directory
In-Reply-To: <1459480051-3701-4-git-send-email-yangbo.lu@nxp.com>
References: <1459480051-3701-1-git-send-email-yangbo.lu@nxp.com>
 <1459480051-3701-4-git-send-email-yangbo.lu@nxp.com>
Message-ID: <20160404051552.GG17806@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 11:07:29AM +0800, Yangbo Lu wrote:
> Move guts devicetree doc to Documentation/devicetree/bindings/soc/fsl/
> since it's used by not only PowerPC but also ARM. And add a specification
> for 'little-endian' property.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- None
> Changes for v4:
> 	- Added this patch
> Changes for v5:
> 	- Modified the description for little-endian property
> Changes for v6:
> 	- None
> Changes for v7:
> 	- None
> ---
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt | 3 +++
>  1 file changed, 3 insertions(+)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)

Acked-by: Rob Herring <robh@kernel.org>
