From: keescook@chromium.org (Kees Cook)
Date: Thu, 17 Oct 2013 14:15:51 -0700
Subject: [RFC] Stricter kernel memory permissions
In-Reply-To: <1381282292-25251-1-git-send-email-lauraa@codeaurora.org>
References: <1381282292-25251-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <CAGXu5jKLYWo3CEOo9KPS4O61GLKRbRBBP4S9ZSGNBa+Opp1PEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 8, 2013 at 6:31 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> This is an RFC to add more page table protection to ARM. As has been alluded to
> in the past[1], the ARM kernel unconditionally maps everything as RWX which
> presents a security problem. This is a fairly straight port of what we've been
> using for a while for mitigation and is mostly provided as an example. Some
> notes:

On x86, there is CONFIG_X86_PTDUMP for providing a view of the kernel
page tables in /sys/kernel/debug/kernel_page_tables. Is there anything
like this for ARM? Or maybe the better question is "how are you
examining the results of your page permission changes?" :)

Thanks,

-Kees

-- 
Kees Cook
Chrome OS Security
