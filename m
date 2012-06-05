From: joe@perches.com (Joe Perches)
Date: Tue, 05 Jun 2012 16:48:09 -0700
Subject: [PATCH 0/8] Rework KERN_<LEVEL>
In-Reply-To: <CAPXgP13J+8-dPpZkSfh9sM3xXujC2Rb9tJaOvGoEPghgdr8jiw@mail.gmail.com>
References: <cover.1338889066.git.joe@perches.com>
 <20120605142826.d92316a0.akpm@linux-foundation.org>
 <1338934303.5780.8.camel@joe2Laptop>
 <20120605151754.a794ac7c.akpm@linux-foundation.org>
 <1338936572.5780.29.camel@joe2Laptop>
 <20120605162910.caccb0d4.akpm@linux-foundation.org>
 <1338939316.11962.3.camel@joe2Laptop>
 <CAPXgP13J+8-dPpZkSfh9sM3xXujC2Rb9tJaOvGoEPghgdr8jiw@mail.gmail.com>
Message-ID: <1338940089.11962.7.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-06 at 01:39 +0200, Kay Sievers wrote:
> Try "echo -e"? The stuff is copied verbatim otherwise.

btw: I didn't change the devkmsg_writev function
which does the decoding of any "<n>" prefix for
printk_emit.
