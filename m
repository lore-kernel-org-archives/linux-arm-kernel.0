From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Tue, 14 Dec 2010 17:10:54 +0200
Subject: [PATCH 0/4] omap: iovmm - fixes for iovmm module
In-Reply-To: <1292332047-8206-1-git-send-email-fernando.lugo@ti.com>
References: <1292332047-8206-1-git-send-email-fernando.lugo@ti.com>
Message-ID: <AANLkTim3i+nAV+isLy+rVZ9gtkeW408G_6BhJAbLJZTL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 14, 2010 at 3:07 PM, Fernando Guzman Lugo
<fernando.lugo@ti.com> wrote:

You are missing a description here.

> Version 6:
> * Rebase on Russell King branch.
> ?- for details see:
> ?http://marc.info/?l=linux-omap&m=129228495723001&w=2

Even if these patches are applied, iommu would still not be usable
form tidspbridge, you need at least this patch:
http://article.gmane.org/gmane.linux.ports.arm.omap/44753

Cheers.

-- 
Felipe Contreras
