From: james.morse@arm.com (James Morse)
Date: Mon, 13 Mar 2017 17:54:13 +0000
Subject: [PATCH v3 03/25] arm64: KVM: Implement HVC_GET_VECTORS in the
 init code
In-Reply-To: <20170306142458.8875-4-marc.zyngier@arm.com>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
 <20170306142458.8875-4-marc.zyngier@arm.com>
Message-ID: <58C6DCC5.8040700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/17 14:24, Marc Zyngier wrote:
> Now that we have an infrastructure to handle hypercalls in the KVM
> init code, let's implement HVC_GET_VECTORS there.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
