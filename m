From: joe@perches.com (Joe Perches)
Date: Tue, 05 Jun 2012 15:11:43 -0700
Subject: [PATCH 0/8] Rework KERN_<LEVEL>
In-Reply-To: <20120605142826.d92316a0.akpm@linux-foundation.org>
References: <cover.1338889066.git.joe@perches.com>
 <20120605142826.d92316a0.akpm@linux-foundation.org>
Message-ID: <1338934303.5780.8.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-05 at 14:28 -0700, Andrew Morton wrote:
> Unfortunately the <n> thing is part of the kernel ABI:
> 
> 	echo "<4>foo" > /dev/kmsg

Which works the same way it did before.
