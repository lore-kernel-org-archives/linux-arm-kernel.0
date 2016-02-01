From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 1 Feb 2016 14:59:33 +0100
Subject: [PATCH v2 09/21] arm64: KVM: VHE: Differenciate host/guest
 sysreg save/restore
In-Reply-To: <1453737235-16522-10-git-send-email-marc.zyngier@arm.com>
References: <1453737235-16522-1-git-send-email-marc.zyngier@arm.com>
 <1453737235-16522-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160201135933.GQ1478@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 03:53:43PM +0000, Marc Zyngier wrote:
> With ARMv8, host and guest share the same system register file,
> making the save/restore procedure completely symetrical.
> With VHE, host and guest now have different requirements, as they
> use different sysregs.
> 
> In order to prepare for this, add split sysreg save/restore functions
> for both host and guest. No functionnal change yet.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
