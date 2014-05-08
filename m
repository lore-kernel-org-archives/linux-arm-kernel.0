From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 8 May 2014 00:20:49 +0000 (UTC)
Subject: [PATCH 1/2] ARM: omap5: hwmod_data: Update McPDM hwmod's flags
In-Reply-To: <1398858208-1346-1-git-send-email-peter.ujfalusi@ti.com>
References: <1398858208-1346-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.02.1405080018490.23579@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi P?ter,

On Wed, 30 Apr 2014, Peter Ujfalusi wrote:

> Add HWMOD_SWSUP_SIDLE to flags.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

This patch could use a better changelog.  It would be ideal to understand 
_why_ HWMOD_SWSUP_SIDLE is needed.  Is there a known hardware bug?  Or is 
this simply based on practical observation, e.g., something bad happens if 
the McPDM is not software-idled?


- Paul
