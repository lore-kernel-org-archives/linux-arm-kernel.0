From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 6 Jul 2011 16:42:08 -0600 (MDT)
Subject: [PATCH v3 09/13] OMAP4: hwmod data: Align interconnect format
	with regular modules
In-Reply-To: <1309554558-19819-10-git-send-email-b-cousson@ti.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
	<1309554558-19819-10-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1107061640100.31498@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> The interconnect modules were using a slightly different layout than
> the regular modules.
> Align the layout for better consitency.

Thanks, this patch has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'omap4_hwmod_data_cleanup_a_3.1' 
branch.


- Paul
