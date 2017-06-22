From: keescook@chromium.org (Kees Cook)
Date: Thu, 22 Jun 2017 11:06:28 -0700
Subject: [PATCH 0/4] Reduce ELF_ET_DYN_BASE
Message-ID: <1498154792-49952-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a follow-up to "binfmt_elf: Use ELF_ET_DYN_BASE only for PIE"[1],
which allow ELF_ET_DYN_BASE to be reduced from high in the address space.
That patch only changed x86, and this series changes arm, arm64, powerpc,
and s390.

Since these depend on the mentioned patch (which I'm hoping akpm will
pick up), I'm hoping to get arch-maintainer Acks for these (so they can
be carried all together).

Thanks!

-Kees

[1] https://patchwork.kernel.org/patch/9802387/
