From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 7 Dec 2012 15:46:46 +0900
Subject: [PATCH V2 1/2] ASoC: Samsung: Do not register samsung audio dma
 device as pdev
In-Reply-To: <1354765837-3469-2-git-send-email-padma.v@samsung.com>
References: <1354765837-3469-1-git-send-email-padma.v@samsung.com>
 <1354765837-3469-2-git-send-email-padma.v@samsung.com>
Message-ID: <20121207064644.GI26070@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 06, 2012 at 09:20:36AM +0530, Padmavathi Venna wrote:
> Previously, the ASoC 'platform' (PCM/DMA) object was instantiated via a
> platform_device. This didn't represent the hardware well, since there
> was no separate hardware associated with this platform_device; it was a
> virtual device with sole purpose to call snd_soc_register_platform().

Looks good however this doesn't apply against my topic/samsung branch -
can you please check if I need anything from Kukjin's tree?  Though I
guess the easiest thing is just to wait until the merge window is over,
we're near to the next release.
