From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Aug 2013 12:18:02 +0100
Subject: [PATCH] ARM: kexec: offline non panic CPUs on Kdump panic
In-Reply-To: <CALicx6tihdPzZYMU5BUL-FUK9EvzvCimc6av=QM92Xa8zBwcBw@mail.gmail.com>
References: <1374817287-27952-1-git-send-email-vijay.kilari@gmail.com>
 <20130726104908.GC17886@mudshark.cambridge.arm.com>
 <51F2ACF7.9000008@wwwdotorg.org>
 <CALicx6ugumPG__rSAsTS95SH=6fTGqhpPFsQ8bLG-u-fbk0=pQ@mail.gmail.com>
 <51F7F0E1.5030200@wwwdotorg.org>
 <CALicx6tJFkGbvKO+-XZixj+8RSh1awFnXK91Pdew1+5Oa+dDqg@mail.gmail.com>
 <51F945F9.3050906@wwwdotorg.org>
 <CALicx6u5tkf_wvX8ZcVwbhUOkt3=Zz7214yR9pVce0TJ82Vt4A@mail.gmail.com>
 <51FA8C13.2060807@wwwdotorg.org>
 <CALicx6tihdPzZYMU5BUL-FUK9EvzvCimc6av=QM92Xa8zBwcBw@mail.gmail.com>
Message-ID: <20130813111802.GD30280@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 01:18:38PM +0100, Vijay Kilari wrote:
> On Thu, Aug 1, 2013 at 9:55 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > OK, if there are explicit measure to assure this already, then there's
> > no issue.
> 
> Hi Will,
> 
>  Can you please consider this patch?

Assuming that Stephen and I are understanding things correctly, then this
patch seems fine.

Can you put it into Russell's patch system please?

Will
