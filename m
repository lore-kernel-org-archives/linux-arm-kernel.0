From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 21 Mar 2013 17:47:31 +0100
Subject: [alsa-devel] [PATCH 0/2] ASoC: dmaengine_pcm: support generic
 DMA binding users
In-Reply-To: <514B34AB.1080107@metafoo.de>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <20130321023858.GD6281@S2101-09.ap.freescale.net>
 <514B21F3.90803@metafoo.de>
 <20130321152206.GA14768@opensource.wolfsonmicro.com>
 <514B34AB.1080107@metafoo.de>
Message-ID: <20130321164731.GB15926@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 05:26:19PM +0100, Lars-Peter Clausen wrote:

> a second step. The first step should already help us to get rid of a large
> portion of redundant code we see in PCM drivers today.

Indeed, factor everything we can out into common code and then improve
the common code in a single place.

> There are some other drivers which don't really depend on runtime filter
> parameters, e.g. tegra, which doesn't use a filter function. So tegra can also
> easily make use of this new generic dmaengine based PCM driver.

Tegra's DT only these days anyway of course.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130321/2d359b73/attachment.sig>
