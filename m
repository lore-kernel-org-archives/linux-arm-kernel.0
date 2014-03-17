From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 17 Mar 2014 14:16:16 +0100
Subject: [PATCH] ata: ahci_sunxi: disable resources on driver removal
In-Reply-To: <4639408.hubNkUp5Oa@amdc1032>
References: <4639408.hubNkUp5Oa@amdc1032>
Message-ID: <1541332.S2AMpmTS9V@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 17, 2014 02:05:15 PM Bartlomiej Zolnierkiewicz wrote:
> Add custom ->host_stop method to disable resources on driver removal.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

After looking some more into ahci_platform.c it seems that this patch
is not needed, sorry for the noise.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
