From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 14 May 2014 17:13:58 +0000 (UTC)
Subject: [PATCH v2] ARM: omap5: hwmod_data: Correct IDLEMODE for McPDM
In-Reply-To: <1399623005-30581-1-git-send-email-peter.ujfalusi@ti.com>
References: <alpine.DEB.2.02.1405081602220.23579@utopia.booyaka.com>
 <1399623005-30581-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.02.1405141713430.21921@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 May 2014, Peter Ujfalusi wrote:

> McPDM need to be configured to NO_IDLE mode when it is in used otherwise
> vital clocks will be gated which results 'slow motion' audio playback.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks, queued for v3.15-rc.

- Paul
