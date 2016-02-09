From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:42:47 +0100
Subject: [PATCH v2 11/28] ARM: KVM: Add vgic v2 save/restore
In-Reply-To: <1454583645-10144-12-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-12-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209184247.GO5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:28AM +0000, Marc Zyngier wrote:
> This patch shouldn't exist, as we should be able to reuse the
> arm64 version for free. I'll get there eventually, but in the
> meantime I need an interrupt controller.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
