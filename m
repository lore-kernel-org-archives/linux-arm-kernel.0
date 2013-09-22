From: tj@kernel.org (Tejun Heo)
Date: Sun, 22 Sep 2013 12:58:17 -0400
Subject: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
In-Reply-To: <1379595943-14622-9-git-send-email-rogerq@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379595943-14622-9-git-send-email-rogerq@ti.com>
Message-ID: <20130922165817.GD30946@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 04:05:36PM +0300, Roger Quadros wrote:
> From: Balaji T K <balajitk@ti.com>
> 
> Some platforms have a PHY hooked up to the
> SATA controller. The PHY needs to be initialized
> and powered up for SATA to work. We do that
> using the PHY framework.
> 
> [Roger Q] Cleaned up.
> 
> CC: Tejun Heo <tj@kernel.org>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Looks okay to me although I don't know whether everyone using
ahci_platform would be happy with requiring phy.  Sergei, does this
look good to you?

Thanks.

-- 
tejun
