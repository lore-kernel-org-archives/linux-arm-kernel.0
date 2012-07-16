From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 16 Jul 2012 17:44:14 +0530
Subject: [PATCHv4 6/8] ARM: OMAP: pm-debug: enhanced usecount debug support
In-Reply-To: <1342439156.4672.66.camel@sokoban>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>	
 <1342189185-5306-7-git-send-email-t-kristo@ti.com>	 <5003F1E9.5080700@ti.com>
 <1342439156.4672.66.camel@sokoban>
Message-ID: <50040596.9000103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012 05:15 PM, Tero Kristo wrote:
>>> >  >
>>> >  >  This patch also provices a way to do printk dumps from kernel code,
>>> >  >  by calling the pm_dbg_dump_X functions. The plan is to call these
>>> >  >  functions once an error condition is detected, e.g. failed suspend.
> ^
> |
> This part is the main motivation for this patch imo.

ah, okay. I missed that part completely.
