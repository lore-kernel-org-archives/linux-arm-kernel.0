From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 14 Jul 2015 14:12:07 +0200
Subject: [PATCH] i2c: omap: fix bus recovery setup
In-Reply-To: <55A4FC19.4040709@ti.com>
References: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
 <20150714111004.GB1517@katana> <55A4FC19.4040709@ti.com>
Message-ID: <20150714121207.GI1517@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 03:10:01PM +0300, Grygorii Strashko wrote:
> Hi Wolfram,
> 
> On 07/14/2015 02:10 PM, Wolfram Sang wrote:
> > On Wed, Jul 08, 2015 at 04:35:27PM +0200, Jan Luebbe wrote:
> >> At least on the AM335x, enabling OMAP_I2C_SYSTEST_ST_EN is not enough to
> > 
> > Felipe: it seems you did not need this; is this AM335x specific?
> 
> We need it (Felipe's reply can be delayed).

So, how did it work for him?

> It's not AM335x specific. TMODE has to be configured for all OMAP4+ SoCs too.

Okay, thanks for the stepping in!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150714/2dd52bbc/attachment.sig>
