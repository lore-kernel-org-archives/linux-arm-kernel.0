From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Dec 2011 17:32:24 +0000
Subject: [PATCH v2 4/9] ASoC: twl6040: Convert MICBIAS to SUPPLY widget
In-Reply-To: <1324571902-16918-5-git-send-email-peter.ujfalusi@ti.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
 <1324571902-16918-5-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20111222173223.GB29622@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 06:38:17PM +0200, Peter Ujfalusi wrote:
> In order to avoid breakage change the omap-abe-twl6040
> machine driver's routing.

It'd be better to put this before all the renaming and whatever, it's a
mostly separate change and it'd save having to look at it again.
