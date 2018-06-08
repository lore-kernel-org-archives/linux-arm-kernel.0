From: james.morse@arm.com (James Morse)
Date: Fri, 8 Jun 2018 18:44:05 +0100
Subject: [PATCH v4 2/3] arm64: KVM: Enable Common Not Private translations
In-Reply-To: <1526638022-4137-3-git-send-email-vladimir.murzin@arm.com>
References: <1526638022-4137-1-git-send-email-vladimir.murzin@arm.com>
 <1526638022-4137-3-git-send-email-vladimir.murzin@arm.com>
Message-ID: <7129ef7f-1e79-612a-4b41-7c6bba327026@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 18/05/18 11:07, Vladimir Murzin wrote:
> We rely on cpufeature framework to detect and enable CNP so for KVM we
> need to patch hyp to set CNP bit just before TTBR0_EL2 gets written.
> 
> For the guest we encode CNP bit while building vttbr, so we don't need
> to bother with that in a world switch.

With the bare-constant fix suggested by Catalin,

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
