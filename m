From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 5 Jan 2011 19:23:07 +0530
Subject: [PATCH] omap: wd_timer: Fix crash frm wdt_probe when
	!CONFIG_RUNTIME_PM
In-Reply-To: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com>
References: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <68789fa8ba11b9427aa6321da55c9a8b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com]
> Sent: Wednesday, January 05, 2011 7:11 PM
> To: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; Santosh Shilimkar; Paul
> Walmsley
> Subject: [PATCH] omap: wd_timer: Fix crash frm wdt_probe when
> !CONFIG_RUNTIME_PM
>
(Removing unnecessary changes which got committed by mistake)
