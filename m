From: mingo@kernel.org (Ingo Molnar)
Date: Thu, 2 Mar 2017 09:01:26 +0100
Subject: [PATCHv2 05/14] x86: Use set_memory.h header
In-Reply-To: <1488413706-9739-6-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-6-git-send-email-labbott@redhat.com>
Message-ID: <20170302080126.GA9574@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Laura Abbott <labbott@redhat.com> wrote:

> 
> set_memory_* functions have moved to set_memory.h. Switch to this
> explicitly.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/x86/kernel/amd_gart_64.c      | 2 +-
>  arch/x86/kernel/cpu/amd.c          | 2 +-
>  arch/x86/kernel/cpu/bugs.c         | 2 +-
>  arch/x86/kernel/ftrace.c           | 2 +-
>  arch/x86/kernel/machine_kexec_64.c | 1 +
>  arch/x86/mm/init.c                 | 2 +-
>  arch/x86/mm/init_64.c              | 2 +-
>  arch/x86/mm/ioremap.c              | 2 +-
>  arch/x86/mm/pageattr.c             | 1 +
>  arch/x86/net/bpf_jit_comp.c        | 1 +
>  arch/x86/pci/pcbios.c              | 2 +-
>  arch/x86/platform/efi/efi.c        | 2 +-
>  arch/x86/realmode/init.c           | 2 +-
>  13 files changed, 13 insertions(+), 10 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
