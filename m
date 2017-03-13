From: james.morse@arm.com (James Morse)
Date: Mon, 13 Mar 2017 17:53:39 +0000
Subject: [PATCH v3 01/25] arm64: hyp-stub: Implement HVC_RESET_VECTORS
 stub hypercall
In-Reply-To: <20170306142458.8875-2-marc.zyngier@arm.com>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
 <20170306142458.8875-2-marc.zyngier@arm.com>
Message-ID: <58C6DCA3.9050403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/17 14:24, Marc Zyngier wrote:
> Let's define a new stub hypercall that resets the HYP configuration
> to its default: hyp-stub vectors, and MMU disabled.
> 
> Of course, for the hyp-stub itself, this is a trivial no-op.
> Hypervisors will have a bit more work to do.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
