From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 May 2012 23:15:39 -0600 (MDT)
Subject: [PATCH 7/7] ARM: OMAP4+: Add prm and cm base init function.
In-Reply-To: <1335952093-12541-8-git-send-email-santosh.shilimkar@ti.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
 <1335952093-12541-8-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1205072314480.9984@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 May 2012, Santosh Shilimkar wrote:

> From: R Sricharan <r.sricharan@ti.com>
> 
> Instead of statically defining seperate arrays for every OMAP4+ archs,
> have a generic init function to populate the arrays. This avoids the
> need for creating new array for every arch added in the future that
> reuses the prm and cm registers read/write code.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks, looks reasonable, will queue this for 3.5.


- Paul
