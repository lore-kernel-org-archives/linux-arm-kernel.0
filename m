From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Thu, 29 Dec 2011 07:23:14 +0000
Subject: [PATCH v5] Consolidate SRAM support
In-Reply-To: <20111229013551.GN15863@b20223-02.ap.freescale.net>
References: <1310300379-2882-1-git-send-email-plagnioj@jcrosoft.com>
 <20111229013551.GN15863@b20223-02.ap.freescale.net>
Message-ID: <B5906170F1614E41A8A28DE3B8D1214304A0B5@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2011 at 07:05:52, Richard Zhao wrote:
> Hi Jean,
> 
> How is this patch going? Freescale imx IRAM clean up depend on it.
> 

We are using a previous version of this patch on TI's AM335x.

AM335x has PRU support, so merging this patch to unify the
Davinci and OMAP SRAM allocation schemes will help here.

Regards,
Vaibhav
