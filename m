From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Aug 2012 11:12:52 -0700
Subject: [PATCH V2 1/6] ASoC: davinci: davinci-pcm does not need to be a
 plaform_driver
In-Reply-To: <1346074004-22172-2-git-send-email-gururaja.hebbar@ti.com>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
 <1346074004-22172-2-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20120827181251.GT4339@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 06:56:39PM +0530, Hebbar, Gururaja wrote:
> Same as the commit 518de86 (ASoC: tegra: register 'platform' from DAIs,
> get rid of pdev). It makes davinci-pcm not a platform_driver but helper
> to register "platform", so that the platform_device for davinci-pcm can
> be saved completely.

Applied, thanks.
