From: albin.tonnerre@free-electrons.com (Albin Tonnerre)
Date: Mon, 1 Feb 2010 23:56:27 +0100
Subject: Uncompressing broken with commit e7db7b4270
In-Reply-To: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
References: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
Message-ID: <20100201224854.GA2534@pc-ran3241>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jan 2010 17:03 +0000, Catalin Marinas wrote :
> Hi,
> 
> For whatever reason, with commit e7db7b4270 (arm: add support for
> LZO-compressed kernels) if the kernel Image goes beyond a certain size
> it fails to uncompress. Reverting this commit solves the problem.
> Removing some random kernel features also solves the uncompressing as
> the kernel image gets smaller.
> 
> Any idea?

I'm going to be really busy with school for the next 2 weeks, so unless someone
has time to dig into the issue, maybe the best option would be to revert this
patch.

Regards,
-- 
Albin Tonnerre, Free Electrons
Kernel, drivers and embedded Linux development,
consulting, training and support.
http://free-electrons.com
