From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 22 Mar 2011 18:06:22 +0530
Subject: [PATCH v17 00/13] davinci vpbe: dm6446 v4l2 driver
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BCEF72A@dbde02.ent.ti.com>
References: <1300197388-3704-1-git-send-email-manjunath.hadli@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024BCEF72A@dbde02.ent.ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C47D7D5@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Manju,

On Tue, Mar 22, 2011 at 12:23:14, Hadli, Manjunath wrote:
> Sekhar, Kevin, 
>  These patches have gone through considerable reviews. 
> Could you please ACK from your end?

I have some minor comments which I have already posted and
once you fix those you can add:

Acked-by: Sekhar Nori <nsekhar@ti.com>

to the platform patches.

> 
> On Tue, Mar 15, 2011 at 19:26:28, Hadli, Manjunath wrote:
> > version17:
> > The more important among the patch history from previous comments 1. Replacing _raw_readl() with readl().

This is not valid.

Thanks,
Sekhar
