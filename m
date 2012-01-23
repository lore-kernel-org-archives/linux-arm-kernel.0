From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 23 Jan 2012 10:15:31 +0100
Subject: [PATCH v3 0/6] ARM: Remove the __ARCH_WANT_INTERRUPTS_ON_CTXSW
 definition
In-Reply-To: <1327081352-13178-1-git-send-email-catalin.marinas@arm.com>
References: <1327081352-13178-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1327310131.2446.1.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-01-20 at 17:42 +0000, Catalin Marinas wrote:
> Hi,
> 
> This is version 3 of the set of patches removing
> __ARCH_WANT_INTERRUPTS_ON_CTXSW on ARM. The series was rebased on top of
> 3.3-rc1 and fixed the conflicts with the kernel/sched/ changes and the
> ARM LPAE patches. There are no functional changes from v2. I plan to
> push this to -next and get it ready for 3.4-rc1.
> 
> Question for Peter/Ingo - how do we merge the first patch that
> introduces finish_arch_post_lock_switch? Do you pick it up or I can
> merge it via rmk (with your ack)?

I'm fine either way, I'll probably ask Ingo to pull your tree so that I
can stack some other patches on top.
