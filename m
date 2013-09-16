From: b32955@freescale.com (Huang Shijie)
Date: Mon, 16 Sep 2013 18:27:35 +0800
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130916101912.GY29403@sirena.org.uk>
References: <522D3B79.3060707@freescale.com> <52318953.6090405@freescale.com>
 <1378979431.2627.402.camel@shinybook.infradead.org>
 <20130913025827.GA3051@gmail.com> <1378999322.4210.95.camel@i7.infradead.org>
 <20130913041208.GD3051@gmail.com> <20130912205644.GW29403@sirena.org.uk>
 <52329AD3.2050608@freescale.com> <20130913102127.GD29403@sirena.org.uk>
 <52366F97.5030402@freescale.com> <20130916101912.GY29403@sirena.org.uk>
Message-ID: <5236DD17.5090203@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?09?16? 18:19, Mark Brown ??:
> I would expect that most controllers would look just the same as they do
> now except for the additional ability to do quad transfers - it'd just
> get told that some transfers should use more data lines.
The SPI is about the byte streams, but the dummy may be not a byte, the
dummy maybe just 4bit.

It is interesting to handle the dummy issue for the future's SPI controller.

thanks
Huang Shijie
