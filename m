From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Mar 2017 16:20:29 +0000
Subject: [PATCH v4 00/28] arm/arm64: KVM: Rework the hyp-stub API
In-Reply-To: <20170321192058.9300-1-marc.zyngier@arm.com>
References: <20170321192058.9300-1-marc.zyngier@arm.com>
Message-ID: <20170322162028.GD25645@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 07:20:30PM +0000, Marc Zyngier wrote:
> * From v3:
>   - Reworked the way we save/restore lr on arm64, making it EL2's job
>   in a consistent way (these are the three initial patches)

Thanks for fixing up the lr use. Feel free to upstream it via the kvm
tree. For the whole series:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
