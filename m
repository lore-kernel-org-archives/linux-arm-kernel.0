From: npiggin@gmail.com (Nicholas Piggin)
Date: Fri, 31 Aug 2018 11:00:54 +1000
Subject: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
In-Reply-To: <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
 <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
Message-ID: <20180831110054.475a3534@roar.ozlabs.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Aug 2018 09:39:38 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Aug 30, 2018 at 9:15 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > It's also had a lot more testing, but has held up nicely so far on arm64.
> > I haven't figured out how to merge this yet, but I'll probably end up pulling
> > the core changes out onto a separate branch.  
> 
> This looks fine, and I'm actually ok getting the core changes through
> the arm64 branch, since this has been discussed across architectures,
> and I think "whoever does the work gets to drive the car".

Well it would help if powerpc say wanted to start using them without a
merge cycle lag. Not a huge issue because powerpc already does
reasonably well here and there's other work that can be done.

I will try to review the core changes carefully next week.

Thanks,
Nick
