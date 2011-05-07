From: vapier.adi@gmail.com (Mike Frysinger)
Date: Sat, 7 May 2011 09:57:36 -0400
Subject: [PATCH] lib: Consolidate DEBUG_STACK_USAGE option
In-Reply-To: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
References: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <BANLkTim4RFeFpj8uJsnm0gazLOMdYr8P1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 7, 2011 at 01:57, Stephen Boyd wrote:
> Most arches define CONFIG_DEBUG_STACK_USAGE exactly the same way.
> Move it to lib/Kconfig.debug so each arch doesn't have to define
> it. This obviously makes the option generic, but that's fine
> because the config is already used in generic code.
>
> It's not obvious to me that sysrq-P actually does anything
> different with this option enabled, but I erred on the side of
> caution by keeping the most inclusive wording.
>
> Cc: uclinux-dist-devel at blackfin.uclinux.org
> ?arch/blackfin/Kconfig.debug ?| ? ?9 ---------

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
