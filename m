From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Nov 2016 00:24:12 +0100
Subject: [PATCH] ARM: lpc32xx: drop duplicate header device.h
In-Reply-To: <1479761945.1477.0.camel@localhost>
References: <319a5803aac795e175306d4978134f0247cf87bc.1479457751.git.geliangtang@gmail.com>
 <31c0875cedae8fe20211b209c85b6e012fa9f6a5.1479457940.git.geliangtang@gmail.com>
 <1479761945.1477.0.camel@localhost>
Message-ID: <5792570.VjCognBBp5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 21, 2016 3:59:05 PM CET Sylvain Lemieux wrote:
> On Fri, 2016-11-18 at 22:21 +0800, Geliang Tang wrote:
> > Drop duplicate header device.h from phy3250.c.
> > 
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>

> Reviewed-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
> 

Applied into arm-soc/next/fixes-non-critical, I see we already merged
your other pull requests, so it seems appropriate to take this
trivial change directly.

	Arnd
