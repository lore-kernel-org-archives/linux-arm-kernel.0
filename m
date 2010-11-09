From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Nov 2010 15:57:56 +0100
Subject: [PATCH] ARM: add support for uncompressed uImage kernel
In-Reply-To: <1289310656-29502-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1289310656-29502-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <20101109145756.GZ16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 02:50:56PM +0100, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
Quite some time ago I suggested something similar.  I'm sure you can
find the mail in the archives.  The result of my patch was the
introduction of a few more Make-targets:

	uImage -> uimage(Image)
	uzImage -> uimage(zImage) (== today's uImage)
	uImagegz -> uimage(gzip(Image))

Russell objected that though.
Today I don't use the kernel Makefile anymore to build uImages, but let
ptxdist do that for me.

Best regards
Uwe
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
