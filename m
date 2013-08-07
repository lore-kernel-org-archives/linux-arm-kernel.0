From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Aug 2013 17:06:06 +0100
Subject: [PATCH 16/20] ASoC: pxa: add DT bindings for pxa2xx-pcm
In-Reply-To: <1375889649-14638-17-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-17-git-send-email-zonque@gmail.com>
Message-ID: <20130807160606.GH6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 05:34:05PM +0200, Daniel Mack wrote:
> The bindings do not carry any resources, as the module only registers
> the ASoC platform driver.

This should be done by the device for the DAI (as with other DT
platforms that have a similar thing where the DMA device is just a
wrapper around dmaengine).  This is slightly funky here, I'll follow up
on the first patch about that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/d40d5b19/attachment.sig>
