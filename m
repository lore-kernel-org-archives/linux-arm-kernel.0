From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 16 Sep 2013 09:32:06 -0400
Subject: [PATCH v2 1/2] Documentation: devicetree: arm: cpus/cpu nodes
 bindings updates
In-Reply-To: <1379330464-27917-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1379330464-27917-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1379330464-27917-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20130916133206.GF19937@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 12:21:03PM +0100, Lorenzo Pieralisi wrote:
> In order to extend the current cpu nodes bindings to newer CPUs
> inclusive of AArch64 and to update support for older ARM CPUs this
> patch updates device tree documentation for the cpu nodes bindings.
> 
> Main changes:
>     - adds 64-bit bindings
>     - define usage of #address-cells
>     - defines behaviour on pre and post v7 uniprocessor systems
>     - adds ARM 11MPcore specific reg property definition
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 391 ++++++++++++++++++++++---
>  1 file changed, 344 insertions(+), 47 deletions(-)

For the Marvell bits:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
