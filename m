From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 07 Jun 2011 14:16:35 +0300
Subject: [PATCH 1/2] MTD: pxa3xx_nand: fix nand detection issue
In-Reply-To: <1307440867-18993-1-git-send-email-leiwen@marvell.com>
References: <1307440867-18993-1-git-send-email-leiwen@marvell.com>
Message-ID: <1307445395.11104.78.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-06-07 at 03:01 -0700, Lei Wen wrote:
> When keep_config is set, the detection would goes different routine.
> That the driver would read out the setting which is set previously
> by bootloader. While most bootloader keep the irq mask as off, and
> current driver need all irq default open, keep_config behavior would
> lead to no irq at all.
> 
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> Tested-by: Daniel Mack <zonque@gmail.com>
> Cc: stable at kernel.org

When the regression was introduced? Commit id?

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
