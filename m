From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 27 Apr 2018 12:04:02 +0200
Subject: [PATCH] reset: uniphier: fix USB clock line for LD20
In-Reply-To: <CAK7LNAQKVD3aKTo_z=zkOdoL--RogoFm0bt-dCBsWFN8BEPpSg@mail.gmail.com>
References: <1523499370-17757-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQKVD3aKTo_z=zkOdoL--RogoFm0bt-dCBsWFN8BEPpSg@mail.gmail.com>
Message-ID: <1524823442.17614.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-04-27 at 18:42 +0900, Masahiro Yamada wrote:
> Philipp,
> 
> 2018-04-12 11:16 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> > For LD20, the bit 5 of the offset 0x200c turned out to be a USB3
> > reset.  The hardware document says it is the GIO reset despite LD20
> > has no GIO bus, confusingly.
> > 
> > Also, fix confusing comments for PXs3.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> 
> Can you take a look at this, please?

Thank you for the reminder, I've applied it to reset/fixes and rebased
reset/next on top to include it.

regards
Philipp
