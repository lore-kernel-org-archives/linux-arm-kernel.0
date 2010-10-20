From: loic.minier@linaro.org (=?iso-8859-1?Q?Lo=EFc?= Minier)
Date: Wed, 20 Oct 2010 21:26:41 +0200
Subject: [patch 1/9] efikamx: read board id
In-Reply-To: <AANLkTimoLQKUjrTHv9xwd8TkGQ3inT_+4-hjfo+Tudj=@mail.gmail.com>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205251.082848683@rtp-net.org>
	<20101019211507.GA28242@pengutronix.de>
	<AANLkTi=SbFy1eFzQ3XUGDjurme=stUSiqmTRVR=EtX5q@mail.gmail.com>
	<20101020091654.GL28166@pengutronix.de>
	<AANLkTimoLQKUjrTHv9xwd8TkGQ3inT_+4-hjfo+Tudj=@mail.gmail.com>
Message-ID: <20101020192641.GA6466@bee.dooz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010, Matt Sealey wrote:
> Uwe, there is no way to tell if the pads have settled, it is entirely
> a hardware problem, just like when GPIOs are at random input states if
> they are not connected to anything: in this case, first of all the
> IOMUX pull downs and then the GPIO change to input takes longer than
> you can safely do it and then immediately read the pins or board
> version 1.1 and below will not ID correctly.

 Is there a strong need to distinguish between all the PCB ids?  You
 could use the TO2 versus TO3 information to decide between 1.1 and 1.3
 PCBs and stop supporting the other (rare) boards?

-- 
Lo?c Minier
