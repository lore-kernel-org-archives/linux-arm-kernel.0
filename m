From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 9 Dec 2016 13:26:32 +0000
Subject: [PATCH v8 02/16] arm: use new phandle allocation functions
In-Reply-To: <20161104173203.21168-3-andre.przywara@arm.com>
References: <20161104173203.21168-1-andre.przywara@arm.com>
 <20161104173203.21168-3-andre.przywara@arm.com>
Message-ID: <f22a4d61-09d2-6562-11f9-f3232cf394b2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/16 17:31, Andre Przywara wrote:
> To refer to the GIC FDT node, we used to pass the GIC phandle to most
> of the functions dealing with FDT nodes.
> Since we now have a global phandle reference, use that to refer to the
> GIC handle in various places and get rid of the now unneeded parameter
> passing.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Despite the comments on the previous patch, this one is a good cleanup.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
