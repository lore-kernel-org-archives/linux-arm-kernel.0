From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 11 Mar 2015 12:00:56 +0100
Subject: [PATCH] pwm: atmel-hlcdc: add errata handling for sama5d4
In-Reply-To: <54E7603A.5010309@atmel.com>
References: <1424447898-2791-1-git-send-email-nicolas.ferre@atmel.com>
 <20150220170613.424edbb5@bbrezillon> <54E7603A.5010309@atmel.com>
Message-ID: <20150311110055.GE22149@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 05:26:34PM +0100, Nicolas Ferre wrote:
> Le 20/02/2015 17:06, Boris Brezillon a ?crit :
> > Hi Nicolas,
> > 
> > On Fri, 20 Feb 2015 16:58:18 +0100
> > Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> > 
> >> sama5d4 SoC also has an errata on the HLCDC PWM. It is the same as the sama5d3
> >> that is forbidding the use of div1 prescaler.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > The "atmel,sama5d4-hlcdc" compatible string is not yet documented in
> > the atmel-hlcdc MFD driver binding, but this shouldn't hurt, so
> 
> Yes, I'll document it when I'm submitting your patches that add the
> compatibility strings to the drivers/mfd/atmel-hlcdc.c. (with
> atmel,at91sam9x5-hlcdc as well).
> 
> > Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

I'll take your word on it that this will be documented, so I've applied
this.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150311/e60785fe/attachment.sig>
