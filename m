From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 15 Apr 2016 17:40:31 +0200
Subject: [PATCH RESEND] gpmi-nand: Handle ECC Errors in erased pages
In-Reply-To: <AM4PR0401MB1841C82A9BCBFF2C55AA4DC397680@AM4PR0401MB1841.eurprd04.prod.outlook.com>
References: <1456059126-25469-1-git-send-email-mpa@pengutronix.de>
 <33206452.D8BR53ndXi@adelgunde>
 <20160415113906.7f971cec@bbrezillon> <1733015.oJ2G1KSZLY@adelgunde>
 <AM4PR0401MB1841C82A9BCBFF2C55AA4DC397680@AM4PR0401MB1841.eurprd04.prod.outlook.com>
Message-ID: <20160415174031.3c088df5@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Apr 2016 15:33:07 +0000
Han Xu <han.xu@nxp.com> wrote:

> >
> > I just did [1] (it applies on top of your patch), but maybe you
> > can test it (I don't have any imx platforms right now) ;).
> 
> Great, thank you :). I just tested the patch and it works for me. The
> erased page bitflips are still detected and fixed. I will send a new
> version then.
> 
> Hi Markus,
> 
> Could you please share how to verify the patch, in other words, how to reproduce the
> UBIFS corruption issue consistently. Thanks.

I should really post a new version of the nandflipbits tool [1].
That's clearly the easiest solution to verify that your bitflip
correction is reliable.


[1]http://lists.infradead.org/pipermail/linux-mtd/2014-November/056634.html

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
