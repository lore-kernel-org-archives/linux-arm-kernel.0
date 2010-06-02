From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 02 Jun 2010 17:53:52 +0100
Subject: [PATCH v2 0/4] Patches for -next
In-Reply-To: <20100602164459.17783.9741.stgit@e102109-lin.cambridge.arm.com>
References: <20100602164459.17783.9741.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <1275497632.23442.27.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-06-02 at 17:48 +0100, Catalin Marinas wrote:
> Catalin Marinas (4):
>       ARM: Remove the domain switching on ARMv6k/v7 CPUs
>       ARM: Use lazy cache flushing on ARMv7 SMP systems
>       ARM: Assume new page cache pages have dirty D-cache
>       ARM: Synchronise the I and D caches via set_pte_at() on SMP systems

Forgot to mention - for easier testing, these patches are also available
in my "proposed" branch at:

http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-2.6-cm.git;a=summary

BTW, does anyone know how to get linux-arm-kernel subscribed to
patchwork.kernel.org? I know we have a patch system but that's only for
final merging rather than RFC patches.

-- 
Catalin
