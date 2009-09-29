From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 29 Sep 2009 15:09:06 +0200
Subject: [PATCH] i2c: imx: check busy bit when START/STOP
In-Reply-To: <4e090d470909290441i7016c4f4g9a929d78838f9b7@mail.gmail.com>
References: <4e090d470909290441i7016c4f4g9a929d78838f9b7@mail.gmail.com>
Message-ID: <20090929130906.GA24212@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Tue, Sep 29, 2009 at 07:41:44PM +0800, Richard Zhao wrote:
> After START, wait busy bit to be set and
> after STOP, wait busy bit to be clear.
> 
> Disable clock when it's possible to save power.

As those are two different issues, could you make two patches out of it? Also,
I think it will make reviewing easier if you'd drop the debug print-outs.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090929/1bb44bad/attachment.sig>
