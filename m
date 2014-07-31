From: olof@lixom.net (Olof Johansson)
Date: Wed, 30 Jul 2014 17:11:26 -0700
Subject: [PATCH 0/4] LLVMLinux: Patches to enable the kernel to be
 compiled with clang/LLVM
In-Reply-To: <1406764649-20326-1-git-send-email-behanw@converseincode.com>
References: <1406764649-20326-1-git-send-email-behanw@converseincode.com>
Message-ID: <CAOesGMjcFr72LU8akuooE-BodAa8X8tyT0biczxepKo37rNArQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 4:57 PM,  <behanw@converseincode.com> wrote:
> From: Behan Webster <behanw@converseincode.com>
>
> This patch set moves from using locally defined named registers to access the
> stack pointer to using a globally defined named register. This allows the code
> to work both with gcc and clang.
>
> The LLVMLinux project aims to fully build the Linux kernel using both gcc and
> clang (the C front end for the LLVM compiler infrastructure project).
>
> Behan Webster (4):
>   arm64: LLVMLinux: Add current_stack_pointer() for arm64
>   arm64: LLVMLinux: Use current_stack_pointer in save_stack_trace_tsk
>   arm64: LLVMLinux: Calculate current_thread_info from
>     current_stack_pointer
>   arm64: LLVMLinux: Use current_stack_pointer in kernel/traps.c

Series:

Reviewed-by: Olof Johansson <olof@lixom.net>
