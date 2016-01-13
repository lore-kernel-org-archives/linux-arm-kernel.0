From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 13 Jan 2016 12:36:28 +0100
Subject: [PATCH 2/3] ARM: dts: imx6ul: add support for Ka-Ro electronics
 TXUL modules
In-Reply-To: <CAOMZO5Dhho3whg8p0t6FARG8vyU158mFc7d8BHxThjojm-dcQg@mail.gmail.com>
References: <1452621710-15336-1-git-send-email-LW@KARO-electronics.de>
 <1452621710-15336-2-git-send-email-LW@KARO-electronics.de>
 <1452621710-15336-3-git-send-email-LW@KARO-electronics.de>
 <CAOMZO5Dhho3whg8p0t6FARG8vyU158mFc7d8BHxThjojm-dcQg@mail.gmail.com>
Message-ID: <20160113123628.303ef0d6@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Tue, Jan 12, 2016 at 4:01 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> 
> > +               spi at 0 {
> > +                       compatible = "spidev";
> > +                       reg = <0>;
> > +                       spi-max-frequency = <54000000>;
> > +               };
> > +
> > +               spi at 1 {
> > +                       compatible = "spidev";
> > +                       reg = <1>;
> > +                       spi-max-frequency = <54000000>;
> > +               };
> > +       };
> 
> If you leave the spidev node, the spi core will complain loudly about it.
>
I know. But this gives the opportunity to test the SPI interface
without any bogus chip definitions.


Lothar Wa?mann
