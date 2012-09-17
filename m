From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 17 Sep 2012 22:24:27 +0000 (UTC)
Subject: [PATCH] mfd: Fix compile for twl-core.c by removing cpu_is_omap
 usage
In-Reply-To: <20120917221406.GG11762@atomide.com>
References: <20120917202943.GV4521@atomide.com>
 <alpine.DEB.2.00.1209172207480.16117@utopia.booyaka.com>
 <20120917221406.GG11762@atomide.com>
Message-ID: <alpine.DEB.2.00.1209172222570.18885@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Sep 2012, Tony Lindgren wrote:

> We need to queue this ASAP and before other patches to fix the
> build breakage in linux next. Then you can merge in that commit
> too, does that work for you?

That's fine, we'll just need a stable commit then that the CCF patches can 
be based on.


- Paul
