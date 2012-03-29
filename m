From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 29 Mar 2012 13:56:06 +0800
Subject: [PATCH] ASoC: sgtl5000: fix power on/off of MIC bias
In-Reply-To: <1332919833-9641-1-git-send-email-shawn.guo@linaro.org>
References: <1332919833-9641-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120329055604.GB19506@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 03:30:33PM +0800, Shawn Guo wrote:
> From: Lionel Xu <Lionel.Xu@freescale.com>
> 
> There is no sound in the recorded wav, to enable recording, the VAG
> should be powered up, and the mic bias resistor should be set up with
> proper value.
> 
> Signed-off-by: Lionel Xu <lionel.xu@freescale.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Zeng Zhaoming <zengzm.kernel@gmail.com>

Mark, I just send a patch authored by Zeng Zhaoming, which fixes the
problem in a more sensible way.  So please ignore this one.

-- 
Regards,
Shawn
