From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 30 Aug 2018 09:39:38 -0700
Subject: [PATCH 00/12] Avoid synchronous TLB invalidation for intermediate
 page-table entries on arm64
In-Reply-To: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
Message-ID: <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 9:15 AM Will Deacon <will.deacon@arm.com> wrote:
>
> It's also had a lot more testing, but has held up nicely so far on arm64.
> I haven't figured out how to merge this yet, but I'll probably end up pulling
> the core changes out onto a separate branch.

This looks fine, and I'm actually ok getting the core changes through
the arm64 branch, since this has been discussed across architectures,
and I think "whoever does the work gets to drive the car".

After all, a lot of the core changes originally came from x86 people
(pretty much all of it, historically). No reason why arm64 can't get
some of that too.

But with the glory comes the blame when something breaks ;)

                Linus
