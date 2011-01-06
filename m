From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 06 Jan 2011 17:08:20 +0200
Subject: [patch v2] mtd: pxa3xx_nand: NULL dereference in pxa3xx_nand_probe
In-Reply-To: <20110106140536.GB1717@bicker>
References: <1294227801.3996.62.camel@sven> <20110106124525.GA1717@bicker>
	<1294321502.2218.5.camel@sven>  <20110106140536.GB1717@bicker>
Message-ID: <1294326500.2219.8.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-01-06 at 17:05 +0300, Dan Carpenter wrote:
> "info->cmdset" gets dereferenced in __readid() so it needs to be
> initialized earlier in the function.  This bug was introduced in 
> 18c81b1828f8 "mtd: pxa3xx_nand: remove the flash info in driver
> structure".
> 
> Cc: stable at kernel.org [2.6.37+]
> Reported-and-tested-by: Sven Neumann <s.neumann@raumfeld.com>
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> v2:  changed the commit text.  added stable at kernel.org and a reported-by tag.

Pushed to l2-mtd-2.6.git, thanks!

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
