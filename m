From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 30 Jun 2011 14:49:14 +0300
Subject: [PATCH] MTD: atmel_nand: fix wrong use of 0 as NULL
In-Reply-To: <1309365676-19210-1-git-send-email-nicolas.ferre@atmel.com>
References: <1309365676-19210-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1309434559.23597.174.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-06-29 at 18:41 +0200, Nicolas Ferre wrote:
> Fixing this error:
> atmel_nand.c:718:20: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Pushed to l2-mtd-2.6.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
