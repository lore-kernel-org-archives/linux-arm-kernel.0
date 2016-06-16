From: florian.fainelli@broadcom.com (Florian Fainelli)
Date: Thu, 16 Jun 2016 09:26:57 -0700
Subject: [PATCH 4/7] ata: ahci_brcmstb: rename to support across Broadcom
 SoC's
In-Reply-To: <1466085215-10246-5-git-send-email-yendapally.reddy@broadcom.com>
References: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
 <1466085215-10246-5-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <5762D351.1050705@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2016 06:53 AM, Yendapally Reddy Dhananjaya Reddy wrote:
> Rename the existing Broadcom STB ahci driver to common
> Broadcom SATA3 driver to share this across Broadcom SoCs.
> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

There is currently nothing referencing AHCI_BRCMSTB in the in-tree
defconfigs, but we should coordinate this change with this patch:

https://patchwork.kernel.org/patch/9130007/

which I have queued locally to send for 4.8, if we know this is going to
be accepted for 4.8, then I can update the patch above.

Other than that:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
