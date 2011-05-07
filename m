From: richard.weinberger@gmail.com (richard -rw- weinberger)
Date: Sat, 7 May 2011 11:34:13 +0200
Subject: [PATCH] lib: Consolidate DEBUG_STACK_USAGE option
In-Reply-To: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
References: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <BANLkTi=h-151_cMPpii6O+kowvc=0WxKjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 7, 2011 at 7:57 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Most arches define CONFIG_DEBUG_STACK_USAGE exactly the same way.
> Move it to lib/Kconfig.debug so each arch doesn't have to define
> it. This obviously makes the option generic, but that's fine
> because the config is already used in generic code.
>
> It's not obvious to me that sysrq-P actually does anything
> different with this option enabled, but I erred on the side of
> caution by keeping the most inclusive wording.
>
> Cc: linux-arch at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: uclinux-dist-devel at blackfin.uclinux.org
> Cc: linux-m32r at ml.linux-m32r.org
> Cc: linux-mips at linux-mips.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-sh at vger.kernel.org
> Cc: sparclinux at vger.kernel.org
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: user-mode-linux-devel at lists.sourceforge.net
> Cc: x86 at kernel.org
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Acked-by: Richard Weinberger <richard@nod.at>

-- 
Thanks,
//richard
