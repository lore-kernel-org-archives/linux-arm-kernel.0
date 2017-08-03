From: keescook@chromium.org (Kees Cook)
Date: Thu, 3 Aug 2017 10:57:08 -0700
Subject: [PATCH 01/11] arm64: docs: describe ELF hwcaps
In-Reply-To: <1500480092-28480-2-git-send-email-mark.rutland@arm.com>
References: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
 <1500480092-28480-2-git-send-email-mark.rutland@arm.com>
Message-ID: <CAGXu5jJnhy5F698QFmXrMb3szmtXnfzqc+=QsukG4+p2k9xEdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 19, 2017 at 9:01 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> We don't document our ELF hwcaps, leaving developers to interpret them
> according to hearsay, guesswork, or (in exceptional cases) inspection of
> the current kernel code.
>
> This is less than optimal, and it would be far better if we had some
> definitive description of each of the ELF hwcaps that developers could
> refer to.
>
> This patch adds a document describing the (native) arm64 ELF hwcaps.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  Documentation/arm64/elf_hwcaps.txt | 133 +++++++++++++++++++++++++++++++++++++

With the kernel docs moving to ReST markup[1], perhaps reformat this
to a .rst file and link to it from somewhere sensible in the ReST
tree, perhaps the userspace API section in
Documentation/userspace-api/index.rst?

-Kees

[1] https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html

-- 
Kees Cook
Pixel Security
