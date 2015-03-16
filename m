From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 16 Mar 2015 16:07:31 +0800
Subject: [PATCH v2] ARM: imx6: Warn when an old DT is detected
In-Reply-To: <1426262737-32762-1-git-send-email-marc.zyngier@arm.com>
References: <1426262737-32762-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150316080729.GL20455@dragon>
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

Applied, thanks.
