From: tj@kernel.org (Tejun Heo)
Date: Sun, 4 May 2014 15:05:30 -0400
Subject: [PATCH v3 0/2] ahci: imx: software workaround for phy reset issue
In-Reply-To: <1399211286-8624-1-git-send-email-shawn.guo@freescale.com>
References: <1399211286-8624-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140504190530.GA26279@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 04, 2014 at 09:48:04PM +0800, Shawn Guo wrote:
> Changes since v2:
>  - Have comment for register definition
>  - Use IMX_ instead of IMX_SATA_ for prefix to make it a bit shorter
> 
> Shawn Guo (2):
>   ahci: imx: add namespace for register enums
>   ahci: imx: software workaround for phy reset issue in resume

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
