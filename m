From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Jun 2013 23:48:00 +0100
Subject: [RFC PATCH 00/11] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <5443580.A5iCQBtp1T@flatron>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <3697657.tZFV7pR81Q@flatron> <20130619192211.GH1403@sirena.org.uk>
 <5443580.A5iCQBtp1T@flatron>
Message-ID: <20130619224800.GL1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 09:32:44PM +0200, Tomasz Figa wrote:
> On Wednesday 19 of June 2013 20:22:11 Mark Brown wrote:

> > No, I didn't - that's most likely it, I didn't really investigate.  I
> > didn't test the watchdog stuff as the clocks didn't get sent to me.

> I always try to keep you on Cc of my patches for s3c64xx, as you are the 
> most active user of this platform (if not the only one other than me) and 
> this was the case for clock patches as well, just checked that.

Yes, I had the clock patches but they depended on something or other I
think.  I did test a previous verion IIRC.  There are other users I'm
aware of (you can probably take a wild guess where from the board)
though they tend not to be terribly active upstream.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/d560287b/attachment.sig>
