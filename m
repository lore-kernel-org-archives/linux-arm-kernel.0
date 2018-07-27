From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Jul 2018 12:41:42 +0100
Subject: [PATCH v5 2/3] arm64: KVM: Enable Common Not Private translations
In-Reply-To: <1529403502-2843-3-git-send-email-vladimir.murzin@arm.com>
References: <1529403502-2843-1-git-send-email-vladimir.murzin@arm.com>
 <1529403502-2843-3-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20180727114142.2llrh6gcotlvs6lk@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 11:18:21AM +0100, Vladimir Murzin wrote:
> We rely on cpufeature framework to detect and enable CNP so for KVM we
> need to patch hyp to set CNP bit just before TTBR0_EL2 gets written.
> 
> For the guest we encode CNP bit while building vttbr, so we don't need
> to bother with that in a world switch.
> 
> Reviewed-by: James Morse <james.morse@arm.com>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(but you should get an ack from the kvm maintainers)
