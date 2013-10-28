From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 28 Oct 2013 14:03:16 -0400
Subject: [Ksummit-2013-discuss] ARM subplatform maintainer mailing list
In-Reply-To: <CAOesGMhc-jPAz5qR-=k=BUicascwjosqx4jYapM4CKKim-Lb7A@mail.gmail.com>
References: <CAOesGMhc-jPAz5qR-=k=BUicascwjosqx4jYapM4CKKim-Lb7A@mail.gmail.com>
Message-ID: <20131028180316.GC26663@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

Adding David and Ted to the thread.

On Fri, Oct 25, 2013 at 05:50:41AM -0700, Olof Johansson wrote:
...
> But it's also useful to have a forum to reach only the submaintainers
> or key contributors in one go without it drowning in patch postings.
> For a while we did it manually with To/Cc headers, but there are too
> many to keep track of that way.
...
> House rules are simple:
...
>  - Tree-wide ARM platform issues? Maybe this is where we'll send it as
> cc, but discuss on LAKML.

After reading through the patch to add "--fixes <commit-ish> to git"
thread on the ks-2013 ml, and the subsequent complaint about it being on
ks-2013, I had an idea.  (Also, the run-away DT thread is a symptom of
the same issue).

Would it be useful to programatically enforce Bcc'ing lists like these?
IOW, if this is the only list address, it can be in the Cc or the To,
but if there's more that one list address, then
arm-platform-maintainers at lists.infradead.org can only be Bcc'd.

I think this would prevent the run-away threads on minimum-traffic
lists, but I'm not sure how feasible it would be to implement and
maintain.

thx,

Jason.
