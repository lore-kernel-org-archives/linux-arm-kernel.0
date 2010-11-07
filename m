From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sun, 7 Nov 2010 10:24:23 -0600
Subject: [PATCH 5/6] omap: iommu: hwmod device enable/disable routines
In-Reply-To: <4CD5C5FF.9050804@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-6-git-send-email-omar.ramirez@ti.com>
	<4CD5C5FF.9050804@ti.com>
Message-ID: <AANLkTimskJ7qWYE1JsoTuu+=ZJdaKSmAiS_8rx30sq5B@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 6, 2010 at 4:17 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> You should use runtime PM directly. That omap_device step is useless.
>
> Moreover, this patch should be merged with the previous one.

Agree, will check on runtime PM.

Regards,

Omar
