From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 10 Jun 2015 21:15:20 +0900
Subject: [PATCH v6 5/6] i2c: at91: print hardware version
In-Reply-To: <55782935.30608@cogentembedded.com>
References: <cover.1433866582.git.cyrille.pitchen@atmel.com>
 <d1fbf4bce3b470409ef3198f551cfc3f8f22ac78.1433866582.git.cyrille.pitchen@atmel.com>
 <5577428C.3090206@cogentembedded.com>
 <20150610080553.GO25800@odux.rfo.atmel.com>
 <55782935.30608@cogentembedded.com>
Message-ID: <20150610121519.GB1592@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>>-	dev_info(dev->dev, "AT91 i2c bus driver.\n");
> >>>+	dev_info(dev->dev, "AT91 i2c bus driver (version: %#x).\n",
> 
> >>    It looks as if you rather print the driver's version. :-)
> 
> > From my point of view, having a version number for a Linux driver would
> >be strange
> 
>    Not everybody shares your opinion.

I tend to agree with Sergei but let's keep things simple: I'll make it
"hw version" before applying.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150610/26157047/attachment.sig>
