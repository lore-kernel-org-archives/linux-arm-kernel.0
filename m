From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 21 Oct 2014 16:46:14 +0200
Subject: [PATCH] power: reset: at91-reset: fix power down register
In-Reply-To: <54466B3A.5030005@atmel.com>
References: <1413829629-8705-1-git-send-email-alexandre.belloni@free-electrons.com>
 <54466B3A.5030005@atmel.com>
Message-ID: <20141021144613.GB12944@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 21, 2014 at 04:18:34PM +0200, Nicolas Ferre wrote:
> On 20/10/2014 20:27, Alexandre Belloni :
> > In the case of at91sam9g45_restart(), the driver is writing
> > AT91_DDRSDRC_LPCB_POWER_DOWN to AT91_DDRSDRC_RTR, this should actually be
> > AT91_DDRSDRC_LPR.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Absolutely:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> If you don't mind Dmitry, I'll take this patch through the at91/arm-soc
> git trees in my next at91-3.18-fixes branch.

Acked-by: Sebastian Reichel <sre@kernel.org>

P.S.: Please update your MAINTAINERS file.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141021/9f2aa6fc/attachment.sig>
