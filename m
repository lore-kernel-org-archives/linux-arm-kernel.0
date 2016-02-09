From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:39:59 +0100
Subject: [PATCH v2 02/28] ARM: KVM: Remove
 __kvm_hyp_code_start/__kvm_hyp_code_end
In-Reply-To: <1454583645-10144-3-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
 <1454583645-10144-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209183959.GG5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:19AM +0000, Marc Zyngier wrote:
> Now that we've unified the way we refer to the HYP text between
> arm and arm64, drop __kvm_hyp_code_start/end, and just use the
> __hyp_text_start/end symbols.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
