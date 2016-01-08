From: tj@kernel.org (Tejun Heo)
Date: Fri, 8 Jan 2016 11:30:36 -0500
Subject: [PATCH 2/4] ata: ahci_brcmstb: disable DIPM support
In-Reply-To: <1452211413-1350-3-git-send-email-f.fainelli@gmail.com>
References: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
 <1452211413-1350-3-git-send-email-f.fainelli@gmail.com>
Message-ID: <20160108163036.GR1898@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 04:03:31PM -0800, Florian Fainelli wrote:
> From: Danesh Petigara <dpetigara@broadcom.com>
> 
> The Broadcom STB SATA host controller does not support device
> initiated power management. Disable support for this feature
> so the driver never sends SETFEATURES commands to the device
> to enable/disable DIPM.
> 
> Signed-off-by: Danesh Petigara <dpetigara@broadcom.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to libata/for-4.5.

Thanks.

-- 
tejun
