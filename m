From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 13 Dec 2011 13:51:31 -0700 (MST)
Subject: [PATCHv11 1/8] ARM: OMAP2+: hwmod: Add API to enable IO ring
 wakeup.
In-Reply-To: <1323713733-13115-2-git-send-email-t-kristo@ti.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
 <1323713733-13115-2-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1112131350530.12046@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero

On Mon, 12 Dec 2011, Tero Kristo wrote:

> From: R, Govindraj <govindraj.raja@ti.com>
> 
> Add API to enable IO pad wakeup capability based on mux dynamic pad and
> wake_up enable flag available from hwmod_mux initialization.
> 
> Use the wakeup_enable flag and enable wakeup capability
> for the given pads. Wakeup capability will be enabled/disabled
> during hwmod idle transition based on whether wakeup_flag is
> set or cleared.
> 
> Map the enable/disable pad wakeup API's to hwmod_wakeup_enable/disable.
> 
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Since you're in the submitter chain for these patches, I'll need your 
Signed-off-by on this patch and the next one.  Okay to add it?


- Paul
