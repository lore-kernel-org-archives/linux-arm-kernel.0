From: computersforpeace@gmail.com (Brian Norris)
Date: Sun, 27 Sep 2015 17:21:15 -0700
Subject: [PATCH] mxc_nand: fix copy_spare
In-Reply-To: <1443020848-28813-1-git-send-email-eric@eukrea.com>
References: <1443020848-28813-1-git-send-email-eric@eukrea.com>
Message-ID: <20150928002115.GC34421@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 05:07:28PM +0200, Eric B?nard wrote:
> it was broken by 35d5d20efad8a04c8c002c7f31241dff973977a6
> "mtd: mxc_nand: cleanup copy_spare function"
> 
[...]
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Added Fixes and -stable tags and pushed to linux-mtd.git. Thanks!

Brian
