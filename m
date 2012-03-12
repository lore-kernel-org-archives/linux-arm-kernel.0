From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 12 Mar 2012 00:51:29 -0600 (MDT)
Subject: [PATCHv5 3/6] ARM: OMAP4 PM: Add IO Daisychain support
In-Reply-To: <4F5D8F2A.1070602@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
 <1331046702-2472-4-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1203092051140.30879@utopia.booyaka.com>
 <4F5D8F2A.1070602@ti.com>
Message-ID: <alpine.DEB.2.00.1203120050360.11332@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Mar 2012, Rajendra Nayak wrote:

> > Signed-off-by: Tero Kristo<t-kristo@ti.com>
> > [paul at pwsan.com: removed MAX_IOPAD_LATCH_TIME declaration; renamed
> 
> But the code below still seems to use it. Is it now defined in some
> common header so the same value is used in omap3 and omap4?

Yes, I put it into prcm-common.h in the previous patch that added it for 
OMAP3.  I'll update that comment to clarify.


- Paul
