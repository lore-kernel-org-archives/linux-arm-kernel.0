From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Mar 2013 10:00:38 -0800
Subject: [PATCH] ARM: OMAP3: board-generic: Add missing omap3_init_late
In-Reply-To: <51237B84.7060105@ti.com>
References: <1361278711-17672-1-git-send-email-rnayak@ti.com>
 <51237B84.7060105@ti.com>
Message-ID: <20130304180036.GM11806@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130219 05:20]:
> On Tuesday 19 February 2013 06:28 PM, Rajendra Nayak wrote:
> >The .init_late callback for OMAP3 has been missing for DT
> >builds, which causes a lot of late PM initializations to
> >be missed in turn.
> >
> >Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >---
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks applying into omap-for-v3.9-rc1/fixes.

Regards,

Tony
