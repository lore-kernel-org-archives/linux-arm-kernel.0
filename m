From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 13 Aug 2018 20:01:41 -0400
Subject: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <CAPhsuW4ymZAxLdDOAz-rKkyb_POA3ibNW7+2G3BE5Mxtntyqsg@mail.gmail.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <20180809143827.GC22636@redhat.com>
 <20180810155813.49259913@gandalf.local.home>
 <CAPhsuW4ymZAxLdDOAz-rKkyb_POA3ibNW7+2G3BE5Mxtntyqsg@mail.gmail.com>
Message-ID: <20180813200141.601a44e0@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Aug 2018 23:14:01 -0700
Song Liu <liu.song.a23@gmail.com> wrote:

> On Fri, Aug 10, 2018 at 12:58 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 9 Aug 2018 16:38:28 +0200
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >  
> >> I need to read this (hopefully final) version carefully. I'll try to do
> >> this before next Monday.
> >>  
> >
> > Monday may be the opening of the merge window (more likely Sunday). Do
> > you think this is good enough for pushing it in this late in the game,
> > or do you think we should wait another cycle?
> >
> > -- Steve  
> 
> We (Facebook) have use cases in production that would benefit from this work, so
> I would rather see this gets in sooner than later. After a brief
> review (I will more
> careful review before Monday), I think this set is not likely to break
> existing uprobes
> (those w/o ref_ctr). Therefore, I think it is safe to put it in this cycle.
> 

It's still going under review, and the merge window is now open. I'd
prefer that this waits till the next merge window.

-- Steve
