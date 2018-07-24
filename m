From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 24 Jul 2018 15:40:48 +0200
Subject: [PATCHv4 01/12] atomic/tty: Fix up atomic abuse in ldsem
In-Reply-To: <20180724130515.ung6ox2p4rgzn746@lakrids.cambridge.arm.com>
References: <20180716113017.3909-1-mark.rutland@arm.com>
 <20180716113017.3909-2-mark.rutland@arm.com>
 <20180724071518.GA7300@gmail.com>
 <20180724092036.GN2494@hirez.programming.kicks-ass.net>
 <20180724092324.vnfowffsla4kja5c@lakrids.cambridge.arm.com>
 <20180724111313.GA14212@gmail.com>
 <20180724130515.ung6ox2p4rgzn746@lakrids.cambridge.arm.com>
Message-ID: <20180724134048.GA30682@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Mark Rutland <mark.rutland@arm.com> wrote:

> > Ok, then these bits will have to wait until Greg's tree goes upstream
> > in about two weeks.
> 
> Ok.
> 
> > Which patches can I apply as a preparatory step?
> 
> Patches 2-6 can be applied now.

Ok, will apply those.

> I guess I should rebase and resend the remaining bits once Greg's tree
> goes upstream?

Yeah, easiest would be to do that once Greg's and tip:locking/core changes (with 
patches 2-6) both got merged by Linus.

Thanks,

	Ingo
