From: aarcange@redhat.com (Andrea Arcangeli)
Date: Thu, 2 Oct 2014 18:54:30 +0200
Subject: [PATCH V4 1/6] mm: Introduce a general RCU get_user_pages_fast.
In-Reply-To: <CAPvkgC3VkmctmD9dROqkAEwi-Njm9zQqVx1=Byttr5_n-J7wYw@mail.gmail.com>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
 <1411740233-28038-2-git-send-email-steve.capper@linaro.org>
 <20141002121902.GA2342@redhat.com>
 <CAPvkgC3VkmctmD9dROqkAEwi-Njm9zQqVx1=Byttr5_n-J7wYw@mail.gmail.com>
Message-ID: <20141002165430.GK2342@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 02, 2014 at 11:18:00PM +0700, Steve Capper wrote:
> mm/gup.c was recently created?
> It may even make sense to move the weak version in a future patch?

I think the __weak stuff tends to go in lib, that's probably why it's
there. I don't mind either ways.

> I'm currently on holiday and have very limited access to email, I'd
> appreciate it if someone can keep an eye out for this during the merge
> window if this conflict arises?

No problem, I assume Andrew will merge your patchset first, so I can
resubmit against -mm patching the gup_fast_rcu too.

Thanks,
Andrea
