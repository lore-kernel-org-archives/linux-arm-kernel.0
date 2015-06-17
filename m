From: tj@kernel.org (Tejun Heo)
Date: Wed, 17 Jun 2015 14:26:32 -0400
Subject: [PATCH] ata: ahci_mvebu: add suspend/resume support
In-Reply-To: <1434543061-3066-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434543061-3066-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150617182632.GJ22637@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 02:11:01PM +0200, Thomas Petazzoni wrote:
> This commit adds suspend/resume support to the ahci_mvebu driver. The
> suspend hook doesn't do anything special despite calling the generic
> ahci_platform_suspend_host() function. However, the resume hook has to
> restore the MBus windows configuration, as well as the regret option.
> 
> Tested on Marvell Armada 388 GP.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to libata/for-4.2.

Thanks.

-- 
tejun
