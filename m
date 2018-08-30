From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 30 Aug 2018 15:43:39 -0400
Subject: [PATCH v9 4/4] perf probe: Support SDT markers having reference
 counter (semaphore)
In-Reply-To: <20180830185026.GI6097@kernel.org>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <20180820044250.11659-5-ravi.bangoria@linux.ibm.com>
 <20180830144531.3011e185@gandalf.local.home>
 <20180830185026.GI6097@kernel.org>
Message-ID: <20180830154339.1a14e4bf@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Aug 2018 15:50:27 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Aug 30, 2018 at 02:45:31PM -0400, Steven Rostedt escreveu:
> > 
> > Arnaldo,
> > 
> > I'm going to be playing with some of the probe code which may conflict
> > with these patches, so I would like to pull these in my tree. But this
> > patch requires an Acked-by from you before I can pull it in.
> > 
> > You OK with this?  
> 
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>  

Awesome, thanks Arnaldo,

-- Steve
