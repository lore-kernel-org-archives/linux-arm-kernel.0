From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 Apr 2014 11:03:51 +0100
Subject: [PATCH v2 00/16] ASoC: fsl-ssi: Driver cleanup
In-Reply-To: <20140404064932.GC20621@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <20140403221406.GI14763@sirena.org.uk>
 <20140404064932.GC20621@pengutronix.de>
Message-ID: <20140404100351.GM14763@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 04, 2014 at 08:49:32AM +0200, Markus Pargmann wrote:

> Thanks for applying this series, but could you please drop it for the
> moment? We found some issues with the baud clock setup for i2s master
> mode and have some fixed patches for the series. So it would be nice to
> get this in without fixups if that's still possible? I could send a v3
> next week.

I've dropped everything after "fsl-ssi: Move debugging to a separate
file" since that didn't compile anyway (though I'll add the binding
document update as a fix).  In future please don't wait until after your
patches have been applied before saying things like this, it's not good
to rebase branches normally.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140404/63779cba/attachment.sig>
