From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 12 May 2014 16:52:42 +0100
Subject: [PATCH v6 0/4] arm64: prerequisites for audit and ftrace
In-Reply-To: <1398851492-16345-1-git-send-email-takahiro.akashi@linaro.org>
References: <1398851492-16345-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140512155242.GF31633@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 10:51:28AM +0100, AKASHI Takahiro wrote:
> AKASHI Takahiro (4):
>   arm64: make a single hook to syscall_trace() for all syscall features
>   arm64: split syscall_trace() into separate functions for enter/exit
>   arm64: Add regs_return_value() in syscall.h
>   arm64: is_compat_task is defined both in asm/compat.h and
>     linux/compat.h

Patches picked by Will and applied to the arm64 for-next/core branch
(should appear in -next at some point).

Thanks.

-- 
Catalin
