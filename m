From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 25 May 2014 16:34:32 +0100
Subject: [PATCH v2 1/9] arm64: KVM: rename pm_fake handler to trap_raz_wi
In-Reply-To: <1400604945-25247-2-git-send-email-marc.zyngier@arm.com>
References: <1400604945-25247-1-git-send-email-marc.zyngier@arm.com>
 <1400604945-25247-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140525153432.GB3866@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 05:55:37PM +0100, Marc Zyngier wrote:
> pm_fake doesn't quite describe what the handler does (ignoring writes
> and returning 0 for reads).
> 
> As we're about to use it (a lot) in a different context, rename it
> with a (admitedly cryptic) name that make sense for all users.
> 
> Reviewed-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
