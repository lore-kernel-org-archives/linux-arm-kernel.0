From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 Apr 2012 09:46:03 -0600 (MDT)
Subject: [PATCH 1/2] ARM: OMAP3: hwmod_data: Rename the common irq for
 McBSP ports
In-Reply-To: <1332169966-25400-1-git-send-email-peter.ujfalusi@ti.com>
References: <1332169966-25400-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.00.1204040945540.8000@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Mar 2012, Peter Ujfalusi wrote:

> Use 'common' as name for the common irq number in hwmod data for the McBSP
> ports. The same name already in use for OMAP2430, and the OMAP4 hwmod data
> will be using the same name.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks, queued for 3.5.

- Paul
