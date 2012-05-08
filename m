From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 May 2012 23:09:44 -0600 (MDT)
Subject: [PATCH 1/7] ARM: OMAP4: Don't compile cm2xxx_3xxx.c for OMAP4
 only builds.
In-Reply-To: <1335952093-12541-2-git-send-email-santosh.shilimkar@ti.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
 <1335952093-12541-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1205072309190.9984@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 May 2012, Santosh Shilimkar wrote:

> Since OMAP4 code base now makes use of OMAP4 specific PRCM functions,
> cm2xxx_3xxx.c need not be compiled for OMAP4 only builds.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

Will remove the stub functions in a separate patch.


- Paul
