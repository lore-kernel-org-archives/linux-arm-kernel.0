From: loeliger@gmail.com (Jon Loeliger)
Date: Fri, 20 Jun 2014 10:31:06 -0500
Subject: A clockevent IRQ delivery question
In-Reply-To: <20140620152335.GT32514@n2100.arm.linux.org.uk>
References: <CAJgR-BjUpaR0cxew+-fz5YcDu0VKzim-rhLF4j1hEnR_4O+Jsg@mail.gmail.com>
 <53A446C0.10200@linaro.org>
 <CAJgR-Bj+tgCpKTT7FxM-1JMvN7CKUgpaikfbXPQx5ep6+7W2mA@mail.gmail.com>
 <20140620152335.GT32514@n2100.arm.linux.org.uk>
Message-ID: <CAJgR-BiLiskWsFOK2Nr7ysTktkkAJnz8p4HJBb_YJReN3KzQXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Note that there is an outstanding bug report that the IRQ affinity
> forcing breaks CPU hotplug... which would be a regression.  Linus'
> policy is that if a bug fix causes a new regression, then the bug
> fix is wrong and needs to be reverted.

Thanks, Russell.  Yeah, I *just* saw that too.

> So... don't hang your hopes on this just yet... the "fix" for this
> _has_ caused a regression elsewhere, and we need to sort out what
> we're doing about that first.

OK, I'll leave things as they stand in my port for now
as that appears to be working even if not ideal yet!

And Daniel, while it looks like I understand it better now (Thanks!),
I'm going to wait a bit to see where that bug settles out! :-)

Thanks,
jdl
