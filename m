From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Sep 2013 13:28:05 +0100
Subject: [PATCH 0/3] perf: parse the dwarf backtrace info from
 .debug_frame section
In-Reply-To: <20130912121953.GX31370@twins.programming.kicks-ass.net>
References: <1378720815-23964-1-git-send-email-jean.pihet@linaro.org>
 <CAFrcx1mQ-P7byYfqP-0bYabUzTDeSWyHFx2FJQ6wQLYEcV_Pxw@mail.gmail.com>
 <20130912121953.GX31370@twins.programming.kicks-ass.net>
Message-ID: <20130912122805.GG15357@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 01:19:53PM +0100, Peter Zijlstra wrote:
> On Thu, Sep 12, 2013 at 02:07:23PM +0200, Jean Pihet wrote:
> > Hi,
> > 
> > -- Adding more maintainers in the To: list --
> > 
> > Ping about the patch set, is this one acceptable for mainline?
> 
> The below looks to be mostly ARM bits and I would suspect Will to take
> care of them.

I wrote those bits too, so I'm happy to take them via my tree. I'd rather
wait for the last patch to have an ack from somebody like Acme (or for them
to take it in the tip/perf tree) before I push anything though.

Cheers,

Will
