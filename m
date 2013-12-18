From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Wed, 18 Dec 2013 09:23:37 +0000
Subject: [PATCH] ASoC: wm8904: fix DSP mode B configuration
In-Reply-To: <1387337183-16814-1-git-send-email-voice.shen@atmel.com>
References: <1387337183-16814-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20131218092337.GD11138@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 11:26:23AM +0800, Bo Shen wrote:
> When wm8904 work in DSP mode B, we still need to configure it to
> work in DSP mode. Or else, it will work in Right Justified mode.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
