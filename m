From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 17 Jul 2011 04:36:02 +0200
Subject: [PATCH 4/7] at91: remove non used at91_spi.h
In-Reply-To: <4E21950B.4040109@vollmann.ch>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
	<1310687525-22486-4-git-send-email-plagnioj@jcrosoft.com>
	<4E2028E1.1060603@vollmann.ch>
	<20110715154636.GA20678@game.jcrosoft.org>
	<4E206E7D.2070708@vollmann.ch>
	<20110716105752.GD20678@game.jcrosoft.org>
	<4E21950B.4040109@vollmann.ch>
Message-ID: <20110717023602.GF20678@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:41 Sat 16 Jul     , Detlef Vollmann wrote:
> On 07/16/11 12:57, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >for the SPI this IP is shared between avr2 and arm so keep it in arch is not
> >acceptable at all
> Thanks.  This was the motivation I missed.
> In this case I think such include files should go somewhere under
> include, so they can be accessed by other drivers.
> And this is really not only true for this at91_spi.h, but also
> for the other headers in this patch series.
no we already have the header in drivers/spi so this one not used at all in
the mainline is drop

if you need to atmel_spi.h for mainline for other drivers you need to post
your patch.

Best Regards,
J.
