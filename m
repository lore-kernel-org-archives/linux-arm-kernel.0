From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 4 Apr 2014 08:52:36 +0200
Subject: [PATCH v2 11/16] ASoC: fsl-ssi: Fix register values when disabling
In-Reply-To: <20140403221143.GH14763@sirena.org.uk>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-12-git-send-email-mpa@pengutronix.de>
 <20140403221143.GH14763@sirena.org.uk>
Message-ID: <20140404065236.GD20621@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 03, 2014 at 11:11:43PM +0100, Mark Brown wrote:
> On Sat, Mar 15, 2014 at 01:44:19PM +0100, Markus Pargmann wrote:
> > The bits we have to clear when disabling are different when the other
> > stream is still active.
> 
> If this is a bug fix I'd have expected to see it at the start of the
> series so we could merge it prior to the rest of the series (which is
> new development) - what practical issues does this bug cause?

I can put it to the beginning of the series. The only 'bug' I could
observe was a enabled SSI unit although all streams were stopped. But I
could not observe any malfunctions through that.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140404/45df2dc2/attachment.sig>
