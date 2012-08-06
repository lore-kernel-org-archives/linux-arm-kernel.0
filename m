From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 6 Aug 2012 16:49:51 +0100
Subject: [PATCH 4/9] ASoC: imx: Don't use {en,dis}able_fiq() calls
In-Reply-To: <CAKGA1bkiHj=zMJXSzoGp3fpLS3POnFXSV5y7sYYFAikqoUT9tQ@mail.gmail.com>
References: <20120805230238.GA1663@lizard>
 <1344207819-3415-4-git-send-email-anton.vorontsov@linaro.org>
 <CAKGA1bkiHj=zMJXSzoGp3fpLS3POnFXSV5y7sYYFAikqoUT9tQ@mail.gmail.com>
Message-ID: <20120806154951.GQ16861@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 10:19:50AM -0500, Matt Sealey wrote:

> it's not compiled in unless absolutely necessary. However, there was a
> rumble that this code may disappear or be reworked in the future
> making this also quite redundant. Since it's not in the

There's no point in the FIQ driver if the DMA drivers are supported.
