From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 22 Jul 2011 11:27:37 +0300
Subject: [PATCH] mtd: s3c2410 nand: Remove uncessary null check
In-Reply-To: <1311230038-6111-1-git-send-email-jhbird.choi@samsung.com>
References: <1311230038-6111-1-git-send-email-jhbird.choi@samsung.com>
Message-ID: <1311323261.20707.13.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-07-21 at 15:33 +0900, jhbird.choi at samsung.com wrote:
> From: Jonghwan Choi <jhbird.choi@samsung.com>
> 
> clk_get() return a pointer to the struct clk or an ERR_PTR().
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>

Pushed to l2-mtd-2.6.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
