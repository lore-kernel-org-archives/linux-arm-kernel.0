From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 02 Oct 2011 23:20:07 +0200
Subject: [PATCH 4/6] ASoC: sh: use correct __iomem annotations
In-Reply-To: <20111002205008.GB4506@opensource.wolfsonmicro.com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-5-git-send-email-arnd@arndb.de>
	<20111002205008.GB4506@opensource.wolfsonmicro.com>
Message-ID: <3365303.m9SmYBJMXM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 October 2011 21:50:09 Mark Brown wrote:
> On Sun, Oct 02, 2011 at 10:28:02PM +0200, Arnd Bergmann wrote:
> > This removes a few unnecessary type casts and avoids
> > sparse warnings.
> 
> Applied, thanks.

Thank you very much for the realtime feedback and patch applying.

	Arnd
