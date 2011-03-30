From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 30 Mar 2011 21:19:12 +0530
Subject: [PATCH 1/2] davinci: mityomapl138: Use correct id for NAND
	controller
In-Reply-To: <1300882542-26039-1-git-send-email-michael.williamson@criticallink.com>
References: <1300882542-26039-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C5E60E3@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Wed, Mar 23, 2011 at 17:45:41, Michael Williamson wrote:
> For the MityDSP-L138/MityARM-1808 SOMS, the NAND controller id (which needs
> to correspond to the chipselect, and is used for controlling the HW ECC
> computation) is not correct.  Fix it.
> 
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>

Will queue these two patches for 2.6.39-rc

Thanks,
Sekhar
