From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Jul 2018 16:06:38 +0100
Subject: [PATCHv4 01/12] atomic/tty: Fix up atomic abuse in ldsem
In-Reply-To: <20180724134048.GA30682@gmail.com>
References: <20180716113017.3909-1-mark.rutland@arm.com>
 <20180716113017.3909-2-mark.rutland@arm.com>
 <20180724071518.GA7300@gmail.com>
 <20180724092036.GN2494@hirez.programming.kicks-ass.net>
 <20180724092324.vnfowffsla4kja5c@lakrids.cambridge.arm.com>
 <20180724111313.GA14212@gmail.com>
 <20180724130515.ung6ox2p4rgzn746@lakrids.cambridge.arm.com>
 <20180724134048.GA30682@gmail.com>
Message-ID: <20180724150638.a3vw5gn3efzvlwmv@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 03:40:48PM +0200, Ingo Molnar wrote:
> 
> * Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > > Ok, then these bits will have to wait until Greg's tree goes upstream
> > > in about two weeks.
> > 
> > Ok.
> > 
> > > Which patches can I apply as a preparatory step?
> > 
> > Patches 2-6 can be applied now.
> 
> Ok, will apply those.

Cheers!

> > I guess I should rebase and resend the remaining bits once Greg's tree
> > goes upstream?
> 
> Yeah, easiest would be to do that once Greg's and tip:locking/core changes (with 
> patches 2-6) both got merged by Linus.

I'll keep an eye out for both of these.

Thanks,
Mark.
