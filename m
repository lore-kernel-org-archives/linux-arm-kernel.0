From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 7 Dec 2012 19:37:46 +0900
Subject: [PATCH RESEND V2 1/2] ASoC: Samsung: Do not register samsung
 audio dma device as pdev
In-Reply-To: <1354868962-7862-2-git-send-email-padma.v@samsung.com>
References: <1354868962-7862-1-git-send-email-padma.v@samsung.com>
 <1354868962-7862-2-git-send-email-padma.v@samsung.com>
Message-ID: <20121207103745.GK26070@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 07, 2012 at 01:59:21PM +0530, Padmavathi Venna wrote:
> Previously, the ASoC 'platform' (PCM/DMA) object was instantiated via a
> platform_device. This didn't represent the hardware well, since there
> was no separate hardware associated with this platform_device; it was a
> virtual device with sole purpose to call snd_soc_register_platform().

Applied, thanks.
