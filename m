From: james.morse@arm.com (James Morse)
Date: Mon, 13 Mar 2017 17:59:21 +0000
Subject: [PATCH v3 05/25] arm64: KVM: Convert __cpu_reset_hyp_mode to
 using __hyp_reset_vectors
In-Reply-To: <20170306142458.8875-6-marc.zyngier@arm.com>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
 <20170306142458.8875-6-marc.zyngier@arm.com>
Message-ID: <58C6DDF9.1020800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/17 14:24, Marc Zyngier wrote:
> We are now able to use the hyp stub to reset HYP mode. Time to
> kiss __kvm_hyp_reset goodbye, and use __hyp_reset_vectors.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
