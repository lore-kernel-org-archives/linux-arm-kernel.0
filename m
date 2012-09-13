From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 13 Sep 2012 16:11:43 +0800
Subject: [PATCH 00/11] ASoC: OMAP: Convert to use dmaengine
In-Reply-To: <1347450427-27627-1-git-send-email-peter.ujfalusi@ti.com>
References: <1347450427-27627-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120913081141.GD20959@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 02:46:56PM +0300, Peter Ujfalusi wrote:
> Hello,
> 
> This series will switch the OMAP audio to use dmaengine.
> The final patch which does the switch was based on Russell King's earlier patch.

I'm fine with this from the ASoC side but it sounds like you're going to
respin anyway.  Are the earlier bits of the series safe to apply without
the last bit, it seems like that's the only bit that really needs a
respin so we may as well go ahead and apply the earlier bits now?
