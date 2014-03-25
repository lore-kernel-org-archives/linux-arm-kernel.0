From: tj@kernel.org (Tejun Heo)
Date: Tue, 25 Mar 2014 15:17:45 -0400
Subject: [PATCH v4 0/4] ata: ahci_platform related cleanups
In-Reply-To: <1395773501-6663-1-git-send-email-b.zolnierkie@samsung.com>
References: <1395773501-6663-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20140325191745.GB3279@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 07:51:37PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series:
> - fixes ahci_platform_data->suspend() handling
> - moves library AHCI platform code to its own file
> - adds a new-style AHCI platform driver for DaVinci DA850 AHCI controller
> - updates DaVinci DA850 platform code
> 
> Changes since v3:
> - updated for ahci_xgene

Aplied 1-4 to libata/for-3.15.

Thanks!

-- 
tejun
