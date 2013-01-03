From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 3 Jan 2013 17:56:46 +0000 (UTC)
Subject: [PATCH 0/2] ARM: OMAP4: Audio regression fix for 3.8 kernel
In-Reply-To: <1357220811-29904-1-git-send-email-peter.ujfalusi@ti.com>
References: <1357220811-29904-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.00.1301031756290.8721@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi P?ter

On Thu, 3 Jan 2013, Peter Ujfalusi wrote:

> I have noticed that in 3.8-rc2 kernel OMAP4 audio is not working correctly. The
> audio playback is in 'slow motion' mode.
> The following two patch fixes this regression.
> 
> We need to lock the ABE DPLL for all OMAP4 revisions not only for 446x and McPDM
> need to be configured to no IDLE mode during activity.

Thanks, both queued for 3.8-rc fixes.

- Paul
