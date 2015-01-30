From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 30 Jan 2015 07:11:18 +0100
Subject: [PATCH 4/6] i2c: busses: add SLIMpro I2C device driver on APM
 X-Gene platform
In-Reply-To: <CAL85gmCuJtS2DMVHc96FtM_nP2++wMXNrrUp0Kvx0qajKsFuCw@mail.gmail.com>
References: <1412726809-7525-1-git-send-email-fkan@apm.com>
 <1412726809-7525-5-git-send-email-fkan@apm.com>
 <1894616.4yY7dajl4R@wuerfel>
 <CAL85gmCuJtS2DMVHc96FtM_nP2++wMXNrrUp0Kvx0qajKsFuCw@mail.gmail.com>
Message-ID: <20150130061118.GA995@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > ctx->dev is probably the wrong device here. The i2c controller is not
> > DMA capable itself, you need to have a pointer to the device that actually
> > performs the DMA here.
> 
> Arnd, I do agree this may not be the best identification. There is no
> representation for this on the Linux side. I could put it as NULL. However,
> there are other i2c bus drivers that seem to do the same thing. Please
> let me know what you think.

For completeness: Those drivers need fixing!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150130/41b913cb/attachment.sig>
