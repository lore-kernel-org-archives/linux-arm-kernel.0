From: schwidefsky@de.ibm.com (Martin Schwidefsky)
Date: Mon, 9 Mar 2015 10:42:03 -0700
Subject: [PATCH v4 08/10] s390: redefine randomize_et_dyn for
 ELF_ET_DYN_BASE
In-Reply-To: <1425503454-7531-9-git-send-email-keescook@chromium.org>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
 <1425503454-7531-9-git-send-email-keescook@chromium.org>
Message-ID: <20150309104203.7767babc@mschwide>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  4 Mar 2015 13:10:52 -0800
Kees Cook <keescook@chromium.org> wrote:

> In preparation for moving ET_DYN randomization into the ELF loader (which
> requires a static ELF_ET_DYN_BASE), this redefines s390's existing ET_DYN
> randomization in a call to arch_mmap_rnd(). This refactoring results in
> the same ET_DYN randomization on s390.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/s390/include/asm/elf.h |  8 +++++---
>  arch/s390/mm/mmap.c         | 11 ++---------
>  2 files changed, 7 insertions(+), 12 deletions(-)

Patch series including this patch works fine
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
