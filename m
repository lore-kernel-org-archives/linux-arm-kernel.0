From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Mar 2012 13:46:45 +0000
Subject: [PATCH] drivers/base: fix compiler warning in SoC export driver -
 idr should be ida
In-Reply-To: <201203172116.30154.arnd@arndb.de>
References: <4F6456BD.9080205@linaro.org> <201203172116.30154.arnd@arndb.de>
Message-ID: <201203291346.45328.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 March 2012, Arnd Bergmann wrote:
> On Saturday 17 March 2012, Lee Jones wrote:
> > 
> > This fixes:
> >   note: expected ?struct ida *? but argument is of type ?struct idr *?
> >   warning: passing argument 1 of ?ida_pre_get? from incompatible pointer type
> > 
> > Reported-by: Arnd Bergman <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >
> >  drivers/base/soc.c |    2 +-
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Greg, are you taking this through your tree?

I've applied it to arm-soc/fixes now. Greg, if you have any objections,
tell me before the weekend and I'll take it out again, otherwise I'll
submit it before -rc1.

	Arnd
