From: mingo@kernel.org (Ingo Molnar)
Date: Sat, 5 May 2018 12:59:04 +0200
Subject: [PATCH] locking/atomics: Shorten the __atomic_op() defines to
 __op()
In-Reply-To: <20180505104858.ap4bfv6ip2vprzyj@gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090903.ebsf5vosgwckxooy@gmail.com>
 <20180505092911.GC12217@hirez.programming.kicks-ass.net>
 <20180505104858.ap4bfv6ip2vprzyj@gmail.com>
Message-ID: <20180505105904.wczhfmerx3pdfmpz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Ingo Molnar <mingo@kernel.org> wrote:

> If that's too then there's a few more things we could do - for example the 
              ^--too much
> attached patch renames a (very minor) misnomer to a shorter name and thus saves on 
> the longest lines, the column histogram now looks like this:

Thanks,

	Ingo
