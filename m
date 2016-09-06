From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 6 Sep 2016 18:53:56 +0800
Subject: next-20160906 build: 2 failures 0 warnings (next-20160906)
In-Reply-To: <4307762.H85fQucTpI@wuerfel>
References: <E1bhC0l-0003y3-Ls@optimist>	<20160906104652.GJ3950@sirena.org.uk>
 <4307762.H85fQucTpI@wuerfel>
Message-ID: <20160906185356.673f572e@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Sep 2016 12:53:56 +0200 Arnd Bergmann wrote:

> On Tuesday, September 6, 2016 11:46:52 AM CEST Mark Brown wrote:
> > On Tue, Sep 06, 2016 at 09:45:43AM +0100, Build bot for Mark Brown wrote:
> > 
> > Today's -next fails to build arm and arm64 defconfigs due to:
> >   
> > > 	arm64-allmodconfig
> > > ../drivers/pwm/pwm-berlin.c:245:35: error: 'struct berlin_pwm_chip' has no member named 'chips'  
> >   
> > > 	arm-allmodconfig
> > > ../drivers/pwm/pwm-berlin.c:245:35: error: 'struct berlin_pwm_chip' has no member named 'chips'  
> > 
> > due to fd47f104003c6 (pwm: berlin: Add suspend/resume support) which was
> > applied yesterday.
> >   
> 
> I've prepared a patch, will send as soon as I have a clean build again.
> 
> 	Arnd

Thierry has already fixed it

sorry for the inconvenience,
Jisheng
