From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 23 Dec 2011 16:28:27 +0000
Subject: [PATCH 5/5] ASoC: mxs: correct 'direction' of
 device_prep_dma_cyclic
In-Reply-To: <1324656420.1633.15.camel@vkoul-udesk3>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
 <1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
 <1324656420.1633.15.camel@vkoul-udesk3>
Message-ID: <20111223162826.GA28036@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2011 at 09:37:00PM +0530, Vinod Koul wrote:

> Has this been applied in soc tree? I don't see it in linux-next or do
> you want this to go thru slave-dma?

I reverted it, it needs to go with the commit that introduces the new
API otherwise it breaks bisection.
