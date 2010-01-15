From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 15 Jan 2010 09:03:39 +0000
Subject: Pull request for bjdooks' next-samsung tree
In-Reply-To: <20100115081602.GA14598@trinity.fluff.org>
References: <20100115081602.GA14598@trinity.fluff.org>
Message-ID: <20100115090339.GD3738@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can we hold off on this, found a build error on s3c24xx.

Kukjin: please remove __init from the front of s5p_init_io definition
in arch/arm/plat-s3c/include/plat/cpu.h and re-submit the relevant
patch.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
