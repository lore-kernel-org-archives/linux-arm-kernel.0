From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 5 Jun 2012 15:17:54 -0700
Subject: [PATCH 0/8] Rework KERN_<LEVEL>
In-Reply-To: <1338934303.5780.8.camel@joe2Laptop>
References: <cover.1338889066.git.joe@perches.com>
 <20120605142826.d92316a0.akpm@linux-foundation.org>
 <1338934303.5780.8.camel@joe2Laptop>
Message-ID: <20120605151754.a794ac7c.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 05 Jun 2012 15:11:43 -0700
Joe Perches <joe@perches.com> wrote:

> On Tue, 2012-06-05 at 14:28 -0700, Andrew Morton wrote:
> > Unfortunately the <n> thing is part of the kernel ABI:
> > 
> > 	echo "<4>foo" > /dev/kmsg
> 
> Which works the same way it did before.

I didn't say it didn't.

What I did say is that echo "\0014">/dev/kmsg will subvert the intent
of the new logging code.  Or might.  But you just ignored all that,
forcing me to repeat myself, irritatedly.
