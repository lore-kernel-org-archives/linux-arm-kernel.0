From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Oct 2011 19:16:11 +0100
Subject: [PATCH 02/26] sound/pxa-zylonite: use a valid device for dev_err()
In-Reply-To: <1317499438-14058-3-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-3-git-send-email-arnd@arndb.de>
Message-ID: <20111002181611.GA2857@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2011 at 10:03:34PM +0200, Arnd Bergmann wrote:
> A recent conversion has introduced references to &pdev->dev, which does
> not actually exist in all the contexts it's used in.

> Replace this with card->dev where necessary, in order to let
> the driver build again.

Applied, thanks.  I'm a bit confused about why this is buried in the
middle of some enormous series of some kind?
