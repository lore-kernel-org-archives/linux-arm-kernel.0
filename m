From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Feb 2018 22:31:28 +0000
Subject: [PATCH v2 0/9] Fix kpti-enabled kernels for Cavium ThunderX
In-Reply-To: <1517227200-20412-1-git-send-email-will.deacon@arm.com>
References: <1517227200-20412-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180206223128.sfb3aodqc6bcbu2m@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 11:59:51AM +0000, Will Deacon wrote:
> Hi all,
> 
> This is version two of the patches I posted on Friday:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/556304.html
> 
> Changes since v1 include:
> 
>   * Use SCTLR_ELx_M instead of open-coded #1
>   * Changed section attributes for .idmap.text to reflect actual mappings
>   * Rejigged phys_to_pte for consistency with pte_to_phys
>   * Added reviewer tags

Queued for 4.16. Thanks.

-- 
Catalin
