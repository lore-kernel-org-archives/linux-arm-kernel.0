From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Mar 2012 22:18:14 +0800
Subject: [alsa-devel] [PATCH] ASoC: sgtl5000: fix power on/off of MIC bias
In-Reply-To: <7FE21149F4667147B645348EC605788514EDFF@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1332919833-9641-1-git-send-email-shawn.guo@linaro.org>
 <7FE21149F4667147B645348EC605788514EDFF@039-SN2MPN1-011.039d.mgd.msft.net>
Message-ID: <20120328141812.GB3254@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 09:52:15AM +0000, Dong Aisheng-B29396 wrote:
> Did you test line-in record?

No, I did not.  I'm playing imx51 babbage board which has no LINE-IN
routed.

> IIRC for line-in record, it may also need VAG_POWER up.
> Then only enable VAG_POWER for mic_bias_event may not be sufficient.
> Will verify it latter when I'm free.
> 
This patch only fixes MIC.  I think you can submit another patch after
you confirm LINE-IN has the same issue.

-- 
Regards,
Shawn
