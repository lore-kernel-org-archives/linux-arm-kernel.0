From: robh@kernel.org (Rob Herring)
Date: Thu, 18 May 2017 20:27:13 -0500
Subject: [PATCH v2 01/18] dt-bindings: arm: amlogic: Reorder boards
In-Reply-To: <20170513143337.14278-2-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
 <20170513143337.14278-2-afaerber@suse.de>
Message-ID: <20170519012713.ntuwon6wmkro6rho@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 13, 2017 at 04:33:20PM +0200, Andreas F?rber wrote:
> Enforce groupment by SoCs, and order alphabetically within the group
> (with some exceptions). This should facilitate adding new boards.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Rebased (new boards added)
>  * Pointed out alphabetical order in the binding, too (Rob)
>  
>  Documentation/devicetree/bindings/arm/amlogic.txt | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
