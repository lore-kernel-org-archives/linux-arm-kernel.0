From: rabin@rab.in (Rabin Vincent)
Date: Sat, 9 Oct 2010 23:13:24 +0530
Subject: [PATCH 2/2] ftrace - add ftrace function_graph support on ARM
In-Reply-To: <4B91A25E.5030707@am.sony.com>
References: <4B91A25E.5030707@am.sony.com>
Message-ID: <AANLkTi=ULuo8upL9W2dCbn26G_i+moEO2EofBxy_fceU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Sat, Mar 6, 2010 at 6:01 AM, Tim Bird <tim.bird@am.sony.com> wrote:
> Add ftrace function-graph tracer support for ARM.
>
> This includes adding code in mcount to check for
> (and call) a registered function graph trace entry
> routine, and adding code to support a return
> trampoline, to catch the function exit.
>
> IRQENTRY_TEXT was added to vmlinux.lds.S (to eliminate
> a compiler error on kernel/trace/trace_functions_graph.c),
> although no routines were marked as __irq_entry.
>
> Signed-off-by: Tim Bird <tim.bird@am.sony.com>

What happened to this?  Do you intend to post a new version of these
patches?  If not, I'd like to post a series which updates this to
current kernels and also adds support for the graph tracer + dynamic
ftrace combo on ARM based on the recent ARM dynamic ftrace support.

Rabin
