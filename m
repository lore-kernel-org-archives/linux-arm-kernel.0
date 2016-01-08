From: tj@kernel.org (Tejun Heo)
Date: Fri, 8 Jan 2016 11:29:15 -0500
Subject: [PATCH 1/4] ata: ahci_brcmstb: enable support for ALPM
In-Reply-To: <1452211413-1350-2-git-send-email-f.fainelli@gmail.com>
References: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
 <1452211413-1350-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <20160108162915.GQ1898@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 04:03:30PM -0800, Florian Fainelli wrote:
> From: Danesh Petigara <dpetigara@broadcom.com>
> 
> Enable support for ALPM in the host controller's capabilities
> register. Also adjust the PLL  timeout to give it enough time
> to lock when the port exits slumber mode.

Applied to libata/for-4.5 w/ minor style adjustments.

Thanks.

-- 
tejun
