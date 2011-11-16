From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 16 Nov 2011 20:19:24 +0100
Subject: [PATCH 1/3] drivers: base: add support for stmp-style devices
In-Reply-To: <CAHXqBFJigr+Ut5vaY-g0uDU3GnHyvHfJH9RsTUBRQ6kW8BmhsQ@mail.gmail.com>
References: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
 <1321440459-4527-2-git-send-email-w.sang@pengutronix.de>
 <201111161744.19733.arnd@arndb.de>
 <CAHXqBFJigr+Ut5vaY-g0uDU3GnHyvHfJH9RsTUBRQ6kW8BmhsQ@mail.gmail.com>
Message-ID: <20111116191924.GB8843@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> +#define STMP_SET_ADDR ? ? ? ? ? ? ? ?0x4
> >> +#define STMP_CLR_ADDR ? ? ? ? ? ? ? ?0x8
> >> +#define STMP_TOG_ADDR ? ? ? ? ? ? ? ?0xc
> >
> > The register numbers should probably go into the implementation file,
> > they are not an interface.
> 
> Those are offsets - for every register there are "shadow" registers
> that do implicit OR, AND NOT, XOR of that register with value written.
> There might be better names for those.

I'm all ears ;)

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111116/84a4d8e0/attachment.sig>
