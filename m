From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 12:26:06 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: add HLCDC drivers as modules
In-Reply-To: <5714ADA4.1020800@atmel.com>
References: <1459347577-15450-1-git-send-email-boris.brezillon@free-electrons.com>
 <5714ADA4.1020800@atmel.com>
Message-ID: <4216448.KxprUkKsZc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2016 11:49:24 Nicolas Ferre wrote:
> Le 30/03/2016 16:19, Boris Brezillon a ?crit :
> > Add the HLCDC drivers to multi_v7_defconfig.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> If it gives more weight:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> BTW, arm-soc guys, I recall that you prefer patches for this kind of
> modification to multi_v7_defconfig... do I recall well or do you want us
> to build a pull-request together with other AT91 defconfig modifications?

My preference is to get a pull request for related defconfig patches
combining the ones for your own platform and for the multi_*_defconfig
files.

Patches are fine if you only have a small number of changes for a particular
topic (defconfig or otherwise).

	Arnd
