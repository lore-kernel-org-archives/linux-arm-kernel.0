From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 25 Aug 2011 14:37:24 +0300
Subject: [PATCH v8 0/4] add the GPMI-NAND support for imx23/imx28
In-Reply-To: <1314169643-23425-1-git-send-email-b32955@freescale.com>
References: <1314169643-23425-1-git-send-email-b32955@freescale.com>
Message-ID: <1314272249.18988.55.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-08-24 at 15:07 +0800, Huang Shijie wrote:
> The patch set is based on tag v3.1-rc2 of linus's tree.
> and it can be git-am to Artem's tree:
> 	http://git.infradead.org/users/dedekind/l2-mtd-2.6.git
> 
> The general-purpose media interface(GPMI) controller is a flexible interface
> to up to several NAND flashs.
> 
> The Bose Ray-Choudhury Hocquenghem(BCH) module is a hardware ECC accelerator.
> 
> With the help of BCH, the GPMI controller can choose to do the hardware ECC or
> not.

I thought that this series will go in via an imx sub-tree. If you want
it to go via the mtd tree, we'd need blessing from the imx subtree
maintainer, I think.

-- 
Best Regards,
Artem Bityutskiy
