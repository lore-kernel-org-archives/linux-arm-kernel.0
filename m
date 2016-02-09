From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:42:52 +0100
Subject: [PATCH v2 12/28] ARM: KVM: Add VFP save/restore
In-Reply-To: <1454583645-10144-13-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-13-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209184252.GP5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:29AM +0000, Marc Zyngier wrote:
> This is almost a copy/paste of the existing version, with a couple
> of subtle differences:
> - Only write to FPEXC once on the save path
> - Add an isb when enabling VFP access
> 
> The patch also defines a few sysreg accessors and a __vfp_enabled
> predicate that test the VFP trapping state.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
