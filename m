From: harald@ccbib.org (Harald Geyer)
Date: Fri, 10 Apr 2015 19:37:15 +0200
Subject: [PATCH] ARM: dts: imx23-olinuxino: Add i2c support
In-Reply-To: <1893593729.135182.1428597263856.JavaMail.open-xchange@oxbaltgw02.schlund.de>
References: <1428515100-1496-1-git-send-email-harald@ccbib.org>
 <1158701263.68321.1428531175931.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <3f0efa88b69ea2e8eb22909b6fbe6f91@imap.cosmopool.net>
 <5526444A.3060805@i2se.com>
 <d8d27c22eb78aed693a977b88ebcc327@imap.cosmopool.net>
 <1893593729.135182.1428597263856.JavaMail.open-xchange@oxbaltgw02.schlund.de>
Message-ID: <E1Ygcrj-00010H-H6@stardust.g4.wien.funkfeuer.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren writes:
> > On Thu, 09 Apr 2015 11:20:10 +0200, Stefan Wahren <stefan.wahren@i2se.com>
> > wrote:
> >
> > > Btw i read that Shawn only want used muxes [1].
> > >
> > > [1] -
> > >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/115779.html
> >
> > If that is an issue, then I'll just test all three pin groups on my
> > olinuxino
> > board. After all it would be really awkward to have only one pin group and
> > that
> > one is labeled "i2c_pins_b" ...
> 
> from my understanding you are free about the labels. So you could
> rename it to "i2c_pins_a" and change the other pin groups.

Theoretically yes, but there are two reasons not to do that:
1) When Fadil Berisha chose the labels he didn't do so arbitrarily. The
   labels make sense the way the pinmux table is organised in the datasheet.
   (otherwise he sure would have chosen "i2c_pins_a" for the default pin
   group on olinuxino).
2) The labels are in use for about two years now by a lot of people. (Yes
   it really takes that long to have this merged.) I would hate to break
   their setups for no strong reason.

Harald
