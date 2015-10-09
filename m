From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 9 Oct 2015 13:02:31 -0400
Subject: [v3 PATCH] arm64: replace read_lock to rcu lock in call_break_hook
In-Reply-To: <20151009090550.GA26278@arm.com>
References: <1444080771-22468-1-git-send-email-yang.shi@linaro.org>
 <20151008235538.GJ3910@linux.vnet.ibm.com>
 <20151009090550.GA26278@arm.com>
Message-ID: <20151009130231.414489c3@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Oct 2015 10:05:50 +0100
Will Deacon <will.deacon@arm.com> wrote:

> > Looks more plausible to me.  Does it look OK to you, Steven?
> 
> This is already in mainline as a fix, so please shout loudly if you think
> it's broken (it looked ok to me and didn't cause any regressions in my
> testing).

Looks good to me.

-- Steve
