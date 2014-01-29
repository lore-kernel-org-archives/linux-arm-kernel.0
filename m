From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 28 Jan 2014 16:23:46 -0800
Subject: [PATCH 4/4] mtd: nand: remove the
 NAND_MAX_PAGESIZE/NAND_MAX_OOBSIZE
In-Reply-To: <1387555350-989-5-git-send-email-shijie8@gmail.com>
References: <1387555350-989-1-git-send-email-shijie8@gmail.com>
 <1387555350-989-5-git-send-email-shijie8@gmail.com>
Message-ID: <20140129002346.GE8919@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 21, 2013 at 12:02:30AM +0800, Huang Shijie wrote:
> There is no reference to these two macros now.
> Just remove them.
> 
> Signed-off-by: Huang Shijie <shijie8@gmail.com>

Now that patch 3 is fixed, I've pushed this patch as well. Thanks for
cleaning this up!

Brian
