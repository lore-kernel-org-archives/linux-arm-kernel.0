From: timur@freescale.com (Timur Tabi)
Date: Mon, 27 Feb 2012 14:27:22 -0600
Subject: [PATCH 1/6] ASoC: fsl: correct get_dma_channel parameter name
In-Reply-To: <1330092582-21180-2-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F4BE72A.9030803@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> The second parameter of function get_dma_channel is actually a property
> name rather than a compatible string, so rename it for less confusing.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
