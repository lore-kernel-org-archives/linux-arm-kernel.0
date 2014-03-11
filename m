From: behanw@converseincode.com (Behan Webster)
Date: Tue, 11 Mar 2014 00:01:44 -0700
Subject: [PATCH] arm: LLVMLinux: use static inline in ARM ftrace.h
In-Reply-To: <1392949370-26422-1-git-send-email-behanw@converseincode.com>
References: <1392949370-26422-1-git-send-email-behanw@converseincode.com>
Message-ID: <531EB4D8.6030207@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/14 18:22, behanw at converseincode.com wrote:
> From: Behan Webster <behanw@converseincode.com>
>
> With compilers which follow the C99 standard (like modern versions of gcc and
> clang), "extern inline" does the wrong thing (emits code for an externally
> linkable version of the inline function). In this case using static inline
> and removing the NULL version of return_address in return_address.c does
> the right thing.
Any input? Is it good as it is?

Behan

-- 
Behan Webster
behanw at converseincode.com
