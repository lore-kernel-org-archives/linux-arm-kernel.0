From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 7 Aug 2014 11:18:28 -0400
Subject: [PATCH v2 4/5] ARM64: add IPI tracepoints
In-Reply-To: <20140807091817.GG13703@arm.com>
References: <1406318733-26754-1-git-send-email-nicolas.pitre@linaro.org>
 <1406318733-26754-5-git-send-email-nicolas.pitre@linaro.org>
 <20140806155237.0a6d7d3c@gandalf.local.home>
 <20140807091817.GG13703@arm.com>
Message-ID: <20140807111828.3c3d827a@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Aug 2014 10:18:17 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Wed, Aug 06, 2014 at 08:52:37PM +0100, Steven Rostedt wrote:
> > Will and Russell,
> > 
> > Can you give me your Acked-by for this, and I can pull it through my
> > tree?
> 
> Looks fine to me:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>
> 
> I'm assuming there's a dependency on other patches going via the tracing
> tree, hence why you're taking this?

Yeah, there's some generic updates to the trace facility for these
tracepoints.

-- Steve
