From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 13 Mar 2015 17:39:07 +0000
Subject: [PATCH v2] ARM: imx6: Warn when an old DT is detected
In-Reply-To: <1426262737-32762-1-git-send-email-marc.zyngier@arm.com>
References: <1426262737-32762-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150313173906.GP21998@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 04:05:37PM +0000, Marc Zyngier wrote:
> Now that the GPC has been converted to be a full blown irqchip
> (and not a mole on the side of the GIC), booting a new kernel
> with an old DT is likely to result in a rough ride for the user.
> 
> This patch makes sure such a situation is promptly detected and
> the user made aware that a DT update is in order.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks for doing this, Marc!

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
