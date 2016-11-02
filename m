From: florian.fainelli@broadcom.com (Florian Fainelli)
Date: Wed, 2 Nov 2016 10:11:29 -0700
Subject: [PATCH v5 1/7] net: phy: broadcom: add bcm54xx_auxctl_read
In-Reply-To: <1478106488-11779-2-git-send-email-jon.mason@broadcom.com>
References: <1478106488-11779-1-git-send-email-jon.mason@broadcom.com>
 <1478106488-11779-2-git-send-email-jon.mason@broadcom.com>
Message-ID: <996f1a15-02ad-cc6f-4889-e4fe6a311639@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2016 10:08 AM, Jon Mason wrote:
> Add a helper function to read the AUXCTL register for the BCM54xx.  This
> mirrors the bcm54xx_auxctl_write function already present in the code.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
