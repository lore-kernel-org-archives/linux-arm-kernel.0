From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Jul 2013 12:20:23 +0100
Subject: [PATCH] ASoC: Samsung: Modify the I2S driver to support I2S on
 Exynos5420
In-Reply-To: <29860116.IF545KsGYb@thinkpad>
References: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
 <29860116.IF545KsGYb@thinkpad>
Message-ID: <20130711112023.GM24508@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 12:43:22PM +0200, Tomasz Figa wrote:
> On Thursday 11 of July 2013 12:38:24 Padmavathi Venna wrote:

> > +- samsung,supports-tdm: If the I2S controller supports TDM, then this flag
> > +  must be enabled.

> I think this should be rather handled by a different compatible value, not a 

This is a bit of a larger project sadly, there was resistance to doing
the DT bindings based on compatible strings using the IP version :(
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130711/5d790561/attachment.sig>
