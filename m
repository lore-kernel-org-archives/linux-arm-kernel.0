From: peter.ujfalusi@ti.com (=?ISO-8859-1?Q?P=E9ter_Ujfalusi?=)
Date: Wed, 24 Oct 2012 12:56:46 +0200
Subject: [PATCH] ARM: dts: OMAP: Move interrupt-parent to the root node
 to avoid duplication
In-Reply-To: <5087BCA6.1020602@ti.com>
References: <5087BCA6.1020602@ti.com>
Message-ID: <5087C96E.7020906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 12:02 PM, Benoit Cousson wrote:
> The interrupt-parent attribute does not have to be added in each
> node since the DT framework will check for the parent as well to get it.
> 
> Create an interrupt-parent for OMAP2, OMAP3, AM33xx and remove the
> attributes from every nodes that were using it.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Sebastien Guiriec <s-guiriec@ti.com>

Thanks Benoit, looks good from my side.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
