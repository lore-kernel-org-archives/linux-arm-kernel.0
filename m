From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Aug 2012 05:39:17 +0000
Subject: [PATCH V5 0/5] clk: mmp: add clock framework for mmp
In-Reply-To: <1345431315-8037-1-git-send-email-xiechao.mail@gmail.com>
References: <1345431315-8037-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <201208200539.17878.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 August 2012, Chao Xie wrote:
> 
> From: Chao Xie <chao.xie@marvell.com>
> 
> v1->v2:
> replace __raw_xxx with xxx_relax
> use ioremap to remap the registers. Finaly it will use device tree to
> get the physical address.
> do not use macro to register clocks, and directly call the functions.
> 
> v2->v3:
> pxa910 will have APB extension clock, so some peripharals will have
> clocks in APB extension base.
> change pxa168-pwm to be pxa910-pwm for pxa910. It will fit the current
> pwm driver.
> 
> v3->v4:
> remove addtional clock name definition
> replace left __raw_xxx
> 
> v4->v5:
> change the format of the file
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
