From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 15 Mar 2013 01:12:11 +0000
Subject: [PATCH 08/10] ASoC: dmaengine_pcm: Add open function for DT DMA
 request
In-Reply-To: <20130314060442.GB27654@S2101-09.ap.freescale.net>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-9-git-send-email-mpa@pengutronix.de>
 <20130312190206.GY19942@opensource.wolfsonmicro.com>
 <20130313021712.GD27461@S2101-09.ap.freescale.net>
 <20130313104945.GI25610@opensource.wolfsonmicro.com>
 <20130314060442.GB27654@S2101-09.ap.freescale.net>
Message-ID: <20130315011210.GB4931@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 02:04:45PM +0800, Shawn Guo wrote:

> I just double checked my mailbox and can only see the conversation
> between you and rmk, nothing particularly on the removal of the const
> from the name parameter.  Or I'm still missing something?

You're missing the bit where I complained about you doing that - you
should be adding the const to the dmaengine side, not removing it from
the client side.  Unless there's some reason it should be modifiable,
but that'd be very surprising.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130315/04bedaa3/attachment.sig>
