From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Aug 2012 13:31:38 +0000
Subject: [PATCH] atmel-ssc: include linux/io.h for raw io
In-Reply-To: <503625B6.1090204@atmel.com>
References: <1344887950-25596-1-git-send-email-joachim.eastwood@jotron.com>
 <503625B6.1090204@atmel.com>
Message-ID: <201208231331.38883.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 August 2012, Nicolas Ferre wrote:
> On 08/13/2012 09:59 PM, Joachim Eastwood :
> > Include linux/io.h for raw io operations in atmel-scc header.
> > 
> > This fixes the following build error:
> >   CC [M]  sound/soc/atmel/atmel_ssc_dai.o
> > sound/soc/atmel/atmel_ssc_dai.c: In function 'atmel_ssc_interrupt':
> > sound/soc/atmel/atmel_ssc_dai.c:171: error: implicit declaration of function '__raw_readl'
> > sound/soc/atmel/atmel_ssc_dai.c: In function 'atmel_ssc_shutdown':
> > sound/soc/atmel/atmel_ssc_dai.c:249: error: implicit declaration of function '__raw_writel'
> > 
> > Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
> 
> Added to at91-fixes for 3.6. Thanks!
> 
> Arnd, can I queue this one in my upcoming pull-request to you?
> 

Sure, no problem.

	Arnd
