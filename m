From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 Mar 2013 16:39:09 +0800
Subject: [PATCH 2/2] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
In-Reply-To: <514C1139.6050309@ti.com>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <1363318601-31505-3-git-send-email-shawn.guo@linaro.org>
 <20130321095718.GO10326@intel.com>
 <20130321145258.GC23109@S2101-09.ap.freescale.net>
 <514C1139.6050309@ti.com>
Message-ID: <20130322083906.GE6281@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 09:07:21AM +0100, Sebastien Guiriec wrote:
> Now I will wait Lars serie to check again on OMAP and let Mark
> comment on the best approach. Whereas update current API like you
> propose or wait Lars series and move on according to the different
> comments done on open function. As OMAP audio DMA binding are
> depending on the chosen solution.

This the case for everyone else who is moving their audio driver to
generic DMA bindings.  For mxs platform that I'm working on, audio
becomes the only one not moving to generic DMA bindings.

Shawn
