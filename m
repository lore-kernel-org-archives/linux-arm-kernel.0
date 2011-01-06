From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 06 Jan 2011 15:33:44 +0000
Subject: [PATCH 1/1] mtd: msm_nand: Add initial msm nand driver support.
In-Reply-To: <1293785680-19850-1-git-send-email-mnalajal@codeaurora.org>
References: <1293785680-19850-1-git-send-email-mnalajal@codeaurora.org>
Message-ID: <1294328027.20779.6.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-12-31 at 14:24 +0530, Murali Nalajala wrote:
> 
> +#define NAND_CMD_STATUS             0x0C
> +#define NAND_CMD_RESET              0x0D 

Er, what?

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
