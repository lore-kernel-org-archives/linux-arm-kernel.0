From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Mar 2014 17:08:15 +0000
Subject: [PATCH v3 1/3] asm-generic: Add generic seccomp.h for secure
 computing mode 1
In-Reply-To: <1394705823-12465-2-git-send-email-takahiro.akashi@linaro.org>
References: <1394705823-12465-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705823-12465-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140314170814.GJ18126@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 10:17:01AM +0000, AKASHI Takahiro wrote:
> Those values (__NR_seccomp_*) are used solely in secure_computing()
> to identify mode 1 system calls. If compat system calls have different
> syscall numbers, asm/seccomp.h may override them.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  include/asm-generic/seccomp.h |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 include/asm-generic/seccomp.h

I think you need an Ack from Arnd on this patch. The other patches in
this series look ok but they depend on the ftrace patches, so we'll have
to sort those out first.

-- 
Catalin
