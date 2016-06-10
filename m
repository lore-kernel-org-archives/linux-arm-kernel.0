From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 10 Jun 2016 17:00:03 +0200
Subject: [PATCH 1/8] ARM: dts: at91: animeo_ip: remove leftovers clock
 definition
In-Reply-To: <57584D40.8080606@atmel.com>
References: <1465404119-28177-1-git-send-email-alexandre.belloni@free-electrons.com>
 <57584D40.8080606@atmel.com>
Message-ID: <20160610150003.GC19050@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2016 at 18:52:16 +0200, Nicolas Ferre wrote :
> Le 08/06/2016 18:41, Alexandre Belloni a ?crit :
> > The clocks group properties and the clock at 0 node have been obsolete for two
> > years, remove them.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> On the whole series:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> > ---
> >  arch/arm/boot/dts/animeo_ip.dts | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 

Applied, now.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
