From: broonie@kernel.org (Mark Brown)
Date: Sat, 27 Jul 2013 15:21:21 +0100
Subject: [PATCH v10 2/7] ASoC: codec: wm9712 simple DT bindings
In-Reply-To: <20130727134452.GF16871@s25.your-server.de>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-3-git-send-email-mpa@pengutronix.de>
 <20130727115950.GF9858@sirena.org.uk>
 <20130727134452.GF16871@s25.your-server.de>
Message-ID: <20130727142121.GI9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 03:44:52PM +0200, Markus Pargmann wrote:
> On Sat, Jul 27, 2013 at 12:59:50PM +0100, Mark Brown wrote:

> > AC'97 is an enumerable bus, we shouldn't need this...

> What do you mean exactly? Is there a way to automaticaly discover
> connected codecs and register them?

Yes, of coure - just read the ID registers.  Look at how the non-ASoC
AC'97 code works.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130727/e7bfe6d5/attachment.sig>
