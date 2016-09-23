From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Sep 2016 18:31:44 +0100
Subject: [RFC PATCH 2/8] thread_info: allow custom in-task thread_info
In-Reply-To: <CALCETrV6G2DU1d7qr=ADas7nk5a77=J6X7ezKxw2_kzdmJGDXg@mail.gmail.com>
References: <1473947349-14521-1-git-send-email-mark.rutland@arm.com>
 <1473947349-14521-3-git-send-email-mark.rutland@arm.com>
 <CALCETrWni0aZ71r-R6oYG98kZvZA8a184UR0YURk_=tXu8HXMw@mail.gmail.com>
 <20160916103101.GA21702@leverpostej>
 <CALCETrUDWiDmLbMqw9sQYEzvDuSVfmT_UscxQXfmf8YYyTOC=Q@mail.gmail.com>
 <20160921102827.GC18176@leverpostej>
 <CALCETrV6G2DU1d7qr=ADas7nk5a77=J6X7ezKxw2_kzdmJGDXg@mail.gmail.com>
Message-ID: <20160923173143.GA29830@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2016 at 03:23:59PM -0700, Andy Lutomirski wrote:
> On Sep 21, 2016 12:28 AM, "Mark Rutland" <mark.rutland@arm.com> wrote:

> > Given all that, can we make the generic thread_info::flags an unsigned
> > long, matching what the thread flag helpers implicitly assume?
> 
> Yes.  Want to send the patch or should I?

I've sent a patch out to LKML [1], though if that doesn't look right I'm
more than happy for you to send a correct one. ;)

Thanks,
Mark.

[1] http://lkml.kernel.org/r/1474651447-30447-1-git-send-email-mark.rutland at arm.com
