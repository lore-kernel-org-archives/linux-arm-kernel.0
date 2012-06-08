From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 Jun 2012 17:18:19 -0600 (MDT)
Subject: [PATCH 05/11] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
In-Reply-To: <1339161773.2091.49.camel@sokoban>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061309.25532.13430.stgit@dusk> <1339161773.2091.49.camel@sokoban>
Message-ID: <alpine.DEB.2.00.1206081717150.17523@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Jun 2012, Tero Kristo wrote:

> There's a bug in this patch, see below.

...

> There should by binary or, not logical here.

Thanks for reporting this, I've added some credit in the patch 
description.  This has been fixed by switching back to using a flag-based 
approach based on some comments from Vaibhav Hiremath.


- Paul
