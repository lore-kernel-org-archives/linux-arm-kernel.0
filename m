From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 6 Jul 2018 06:51:16 +0100
Subject: [PATCHv3 08/12] atomics: switch to generated fallbacks
In-Reply-To: <20180705172306.GG2494@hirez.programming.kicks-ass.net>
References: <20180705164053.10073-1-mark.rutland@arm.com>
 <20180705164053.10073-9-mark.rutland@arm.com>
 <20180705172306.GG2494@hirez.programming.kicks-ass.net>
Message-ID: <20180706055115.we4yegemiiqe4zdm@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2018 at 07:23:06PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 05, 2018 at 05:40:49PM +0100, Mark Rutland wrote:
> 
> > * The fallbacks are not expected to change very often, and are not
> >   affected by machine details or configuration options, so regenerating
> >   them for *every* build is somewhat wasteful.
> 
> Except of course, your last patch in this series now does exactly that
> :-)

Second-last, but agreed. ;)

I'll reword this to:

* The fallbacks are not affected by machine details or configuration options,
  so it is not necessary to regenerate them to take these into account.

Thanks,
Mark.
