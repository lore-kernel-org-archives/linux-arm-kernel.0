From: mingo@kernel.org (Ingo Molnar)
Date: Thu, 5 Mar 2015 07:31:43 +0100
Subject: [PATCH v3 8/8] x86: switch to using asm-generic for seccomp.h
In-Reply-To: <1425518828-16017-9-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
 <1425518828-16017-9-git-send-email-keescook@chromium.org>
Message-ID: <20150305063143.GA23023@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Kees Cook <keescook@chromium.org> wrote:

> Switch to using the newly created asm-generic/seccomp.h for the 
> seccomp strict mode syscall definitions. The obsolete sigreturn 
> syscall override is retained in 32-bit mode, and the ia32 syscall 
> overrides are used in the compat case. Remaining definitions were 
> identical.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
