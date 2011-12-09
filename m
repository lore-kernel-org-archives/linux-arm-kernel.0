From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Dec 2011 16:55:37 -0800
Subject: [PATCH 2/3] arm/dts: OMAP: Remove bootargs node from board files
In-Reply-To: <4EDE59B8.1070808@gmail.com>
References: <y> <1323190149-6492-3-git-send-email-b-cousson@ti.com>
 <4EDE59B8.1070808@gmail.com>
Message-ID: <20111209005537.GL31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [111206 09:35]:
> Benoit,
> 
> On 12/06/2011 10:49 AM, Benoit Cousson wrote:
> > Since 3.2, the CONFIG_ARM_ATAG_DTB_COMPAT config allows
> > an old bootloader to still use ATAG to provide cmdline.
> > 
> > Remove chosen/bootargs from the DTS board files.
> > 
> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Thanks applying patches 1 & 2 into omap dt branch.
Still wondering if we should combine patch 3 into
some other cleanup to avoid extra churn..

Tony
