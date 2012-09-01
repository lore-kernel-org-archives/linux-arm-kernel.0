From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 1 Sep 2012 11:12:25 +0200
Subject: [PATCH 8/8] ARM: dts: add twi nodes for atmel boards
In-Reply-To: <5040D31E.8040306@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
 <1346405096-18660-1-git-send-email-ludovic.desroches@atmel.com>
 <20120831144228.GC23867@game.jcrosoft.org>
 <5040D31E.8040306@atmel.com>
Message-ID: <20120901091225.GB17540@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:07 Fri 31 Aug     , Nicolas Ferre wrote:
> On 08/31/2012 04:42 PM, Jean-Christophe PLAGNIOL-VILLARD :
> > On 11:24 Fri 31 Aug     , ludovic.desroches at atmel.com wrote:
> >> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> >>
> >> Use the atmel twi instead of gpio for i2c stuff.
> > NACK as you do not update al the platform at the same time and break the Calao
> 
> Yes, Ludovic shall keep i2c-gpio at the side of the new twi driver.
> 
> But for the platform, the platform maintainer will have to choose the
> one or the other.
agreed the platform maintianer need to choose to switch or not

Best Regards,
J.
