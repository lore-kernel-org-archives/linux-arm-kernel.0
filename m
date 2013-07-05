From: wangyuhang2014@gmail.com (yuhang wang)
Date: Fri, 5 Jul 2013 16:48:22 +0800
Subject: SPI: DUAL/QUAD support
In-Reply-To: <51D67851.8020402@ti.com>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
 <20130704130017.GA25997@sig21.net>
 <OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
 <20130704154927.GE27646@sirena.org.uk>
 <OFAD729A05.8C915625-ONC1257B9E.00576B25-C1257B9E.0058477D@rohde-schwarz.com>
 <CAHSAbzOg+uHndydSC43moF7pijc67pqzB2rPnY69ynXHEzw79g@mail.gmail.com>
 <51D67851.8020402@ti.com>
Message-ID: <CAHSAbzNvMo_oeaqtzO8-xDm-L-f8wVccVqfuVqbR=OwqWJhVwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> To add to all the discussion going on,
> I am using a qspi controller with a spansion flash device.
> I tried using quad read mode bit, and what is required to change in
> my case is the following:
>
> 1. enable quad mode in flash configuration register.
> 2. change my read opcode to QUAD READ opcode according to flash datasheet.
> 3. Configure my qspi controller cmd reg to use 6 PIN whenever quad mode is
> used.
>

Sorry, to the third point I am still not very clear. The first time,
spi controller should send
QUAD READ opcode to your spansion flash with 1 line, then receive datas from
flash with 4 lines. So how does your controller master this process
automatically.

Please give me some details.

Thanks
