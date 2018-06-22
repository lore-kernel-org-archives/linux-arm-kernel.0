From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Jun 2018 17:17:06 +0100
Subject: [PATCH v2] arm64: kpti: Use early_param for kpti= command-line
 option
In-Reply-To: <1529659525-21340-1-git-send-email-will.deacon@arm.com>
References: <1529659525-21340-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180622161706.p7kzloyz7nosdy2k@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 10:25:25AM +0100, Will Deacon wrote:
> We inspect __kpti_forced early on as part of the cpufeature enable
> callback which remaps the swapper page table using non-global entries.
> 
> Ensure that __kpti_forced has been updated to reflect the kpti=
> command-line option before we start using it.
> 
> Reported-by: Wei Xu <xuwei5@hisilicon.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Applied. Thanks.

-- 
Catalin
