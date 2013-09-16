From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Sep 2013 11:19:12 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <52366F97.5030402@freescale.com>
References: <522D3B79.3060707@freescale.com> <52318953.6090405@freescale.com>
 <1378979431.2627.402.camel@shinybook.infradead.org>
 <20130913025827.GA3051@gmail.com>
 <1378999322.4210.95.camel@i7.infradead.org>
 <20130913041208.GD3051@gmail.com>
 <20130912205644.GW29403@sirena.org.uk>
 <52329AD3.2050608@freescale.com>
 <20130913102127.GD29403@sirena.org.uk>
 <52366F97.5030402@freescale.com>
Message-ID: <20130916101912.GY29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 10:40:23AM +0800, Huang Shijie wrote:
> ? 2013?09?13? 18:21, Mark Brown ??:
> > You will need to create them.

> thanks. I will try to do it if i have to do.

> I just wonder : what other SPI controller driver would like if the
> controllers is going to support the
> quad-read ?

I would expect that most controllers would look just the same as they do
now except for the additional ability to do quad transfers - it'd just
get told that some transfers should use more data lines.

With this controller it looks like even for normal SPI transfers it's
going to work better knowing that it's doing flash operations.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130916/09b3896c/attachment.sig>
