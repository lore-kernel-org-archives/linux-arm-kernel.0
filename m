From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Feb 2016 11:53:03 +0900
Subject: [PATCH] Revert "regulator: tps65217: remove tps65217.dtsi file"
In-Reply-To: <56C98315.1000707@denx.de>
References: <1455891139-6139-1-git-send-email-peter.ujfalusi@ti.com>
 <20160219170404.GH21202@atomide.com> <56C98315.1000707@denx.de>
Message-ID: <20160222025303.GL18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 21, 2016 at 10:27:49AM +0100, Heiko Schocher wrote:
> Am 19.02.2016 um 18:04 schrieb Tony Lindgren:
> >* Peter Ujfalusi <peter.ujfalusi@ti.com> [160219 06:14]:

> >I'll apply this revert into omap-for-v4.5/fixes as it fixes a
> >regression.

> Sorry for breaking ... but I have no bbw hw for testing ...
> (This is maybe a reason for having something like an automated
>  testsystem, see an example/proposal here:

Or sending boards to kernelci.org for that matter.

> But I removed this file as Mark Brown suggested it, see:

> https://lkml.org/lkml/2015/10/21/581

> So please introduce a "tps65217-am335x.dtsi" file ... Mark?

This is an OMAP DTS file, it needs the OMAP people to work on it - DT
updates don't go through the driver trees usually.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160222/6fc13fec/attachment.sig>
