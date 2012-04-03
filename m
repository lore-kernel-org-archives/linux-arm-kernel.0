From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 3 Apr 2012 21:34:10 +0200
Subject: [PATCH 3/3] ARM: mx28evk: Add SPI NOR flash support
In-Reply-To: <CAOMZO5Dnw0+1GCnS_RgGRr3Ouf51uX=2pBi=w9Qw1OiK695b-A@mail.gmail.com>
References: <1333480807-10480-1-git-send-email-festevam@gmail.com>
 <1333480807-10480-3-git-send-email-festevam@gmail.com>
 <20120403192653.GA2201@pengutronix.de>
 <CAOMZO5Dnw0+1GCnS_RgGRr3Ouf51uX=2pBi=w9Qw1OiK695b-A@mail.gmail.com>
Message-ID: <20120403193410.GB2201@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > However, I think this patch should include registering the spi-device as well?
> 
> It does register it by doing: mx28_add_mxs_spi(2);

Doh, right!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120403/ab67b25d/attachment.sig>
