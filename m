From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 07 Nov 2014 14:48:20 -0800
Subject: [PATCH v7 0/5] This is the 1st version of suspend for RK3288.
In-Reply-To: <1415368177-6637-1-git-send-email-zyw@rock-chips.com> (Chris
 Zhong's message of "Fri, 7 Nov 2014 21:49:32 +0800")
References: <1415368177-6637-1-git-send-email-zyw@rock-chips.com>
Message-ID: <7hwq76pqyz.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris Zhong <zyw@rock-chips.com> writes:

> RK3288 can shut down the cpu, gpu and other device controllers in suspend,
> and it will pull the GLOBAL_PWROFF pin to high in the final stage of the
> process of suspend, pull the pin to low again when resume.

The cover letter still doesn't state what this series applies to, or
what its dependencies are for testing, even though it was requested in
earlier reviews[1].  I discovered (again) by trial and error it applies
to current linux-next.  I also discovered (as was earlier discussed[2])
that it still does not resume using current upstream code, and those
dependencies are not described here either.  These are the kinds of
things that are crucial in a cover letter in order to help reviewers and
testers not have to spend time digging through the archives trying to
remember from the previous round of reviews. 

Please, please list the out-of-tree dependencies, and how to test,
including how you tested it, and on what hardware.

Speaking of earlier reviews, I've noticed that after reviewing this
series multiple times, you never respond to questions and/or comments.
Two-way communication is important when collaborating on getting complex
code this upstream, so please take some time to acknowledge the comments
of reviewers and engage in discussion when questions are asked.  Even if
it's as simple as "OK, I'll fix it in the next version", that helps
reviewers know that they're not wasting their time.

Kevin

[1] https://lkml.org/lkml/2014/10/29/759
[2] https://lkml.org/lkml/2014/10/29/881
