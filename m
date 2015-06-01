From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 1 Jun 2015 12:05:46 +0200
Subject: [PATCH] KVM: arm: vgic: Drop useless Group0 warning
In-Reply-To: <1432917015-31439-1-git-send-email-marc.zyngier@arm.com>
References: <1432917015-31439-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150601100546.GA28473@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 05:30:15PM +0100, Marc Zyngier wrote:
> If a GICv3-enabled guest tries to configure Group0, we print a
> warning on the console (because we don't support Group0 interrupts).
> 
> This is fairly pointless, and would allow a guest to spam the
> console. Let's just drop the warning.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
