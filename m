From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 26 Mar 2010 03:55:48 +0000
Subject: [C/R ARM][PATCH 3/3] c/r: ARM implementation of checkpoint/restart
In-Reply-To: <20100326030208.GA5815@linux-sh.org>
References: <1269219965-23923-1-git-send-email-christofferdall@christofferdall.dk>
	<1269219965-23923-4-git-send-email-christofferdall@christofferdall.dk>
	<20100323211843.GC19572@n2100.arm.linux.org.uk>
	<7d08b87d1003241348g347f092k1142318490e0bdcc@mail.gmail.com>
	<20100326024759.GN19308@shareable.org>
	<20100326030208.GA5815@linux-sh.org>
Message-ID: <20100326035548.GT19308@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Mundt wrote:
> FDPIC supports running the same binaries with or without MMU depending on
> your ABI, it's not really that uncommon, even if it's mostly just used
> for prototyping.

Thanks - I didn't know anyone actually did it :-)

But I can see the value for product rollouts of some binaries onto a
mixture of hardware, too.

bFLT (flat) binaries should be runnable with an MMU too.

-- Jamie
