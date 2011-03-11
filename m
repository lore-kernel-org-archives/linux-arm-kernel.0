From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 11 Mar 2011 12:17:04 +0000
Subject: [PATCH RFC] arm: mini2440: Fix uda134x codec problem.
In-Reply-To: <1299703580-3957-1-git-send-email-marek.belisko@open-nandra.com>
References: <1299703580-3957-1-git-send-email-marek.belisko@open-nandra.com>
Message-ID: <20110311121704.GF1760@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2011 at 09:46:20PM +0100, Marek Belisko wrote:
> ASoC audio for mini2440 platform in current kenrel doesn't work.
> First problem is samsung_asoc_dma device is missing in initialization.
> Next problem is with codec. Codec is initialized but never probed

Applied, thanks.  With changes like this you should really split things
up into a small patch series - if you ever find yourself writing
"Next problem..." or "Also..." then going on to describe a separate
change that's a sign that you should be writing a separate patch.
