From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 28 Jan 2011 12:25:24 +0000
Subject: [PATCH] ASoC: DaVinci: fix kernel panic due to uninitialized
	platform_data
In-Reply-To: <1296136063-31625-1-git-send-email-prakash.pm@ti.com>
References: <1296136063-31625-1-git-send-email-prakash.pm@ti.com>
Message-ID: <20110128122524.GA10350@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 07:17:43PM +0530, Manjunathappa, Prakash wrote:
> This patch fixes the Kernel panic issue on accessing davinci_vc in
> cq93vc_probe function. struct davinci_vc is part of platform device's
> private driver data(codec->dev->p->driver_data) and this is populated
> by DaVinci Voice Codec MFD driver.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Applied, thanks.
