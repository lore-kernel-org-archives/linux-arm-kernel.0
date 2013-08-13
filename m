From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Aug 2013 13:02:03 +0100
Subject: [PATCH 10/18] spi: s3c64xx: Do not require legacy DMA API in
 case of S3C64XX
In-Reply-To: <2472314.6b8DcBdcjO@flatron>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-11-git-send-email-tomasz.figa@gmail.com>
 <20130812233641.GL6427@sirena.org.uk> <2472314.6b8DcBdcjO@flatron>
Message-ID: <20130813120203.GW6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 01:49:53AM +0200, Tomasz Figa wrote:

> I've been testing this without any significant patches, like PWM, CCF or 
> DT support, just everything from the branch I pointed to and some board-
> specific patches to help in debugging.

I retested with the SPI patches you sent separately yesterday which
didn't make a difference for the SPI issue.

> Anyway, this is the exact branch I've been using:

> git://github.com/tom3q/linux.git v3.12-pl080-devel

I can't test this directly as it has the DAPM bugs I fixed yesterday
in it (those patches will hit -next tomorrow), however it does look like
there's nothing else relevant in there...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/d728e4e8/attachment.sig>
