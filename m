From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 03 Apr 2014 11:58:51 +0200
Subject: [GIT PULL 5/6] Samsung PM updates for v3.15
In-Reply-To: <015d01cf4f1e$8153a6f0$83faf4d0$@samsung.com>
References: <8259832.260591393840570438.JavaMail.weblogic@epml16>
 <20140403071912.8250.98981@quantum>
 <015d01cf4f1e$8153a6f0$83faf4d0$@samsung.com>
Message-ID: <2387249.KfAueze2Lh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 3. April 2014, 18:24:25 schrieb Kukjin Kim:
> Mike Turquette wrote:
> > Quoting Kukjin Kim (2014-04-01 21:25:45)
> > 
> > > Heiko St?bner wrote:
> > > > Hi Arnd,
> > > > 
> > > > Am Samstag, 29. M?rz 2014, 02:47:33 schrieb Arnd Bergmann:
> > > > > On Friday 28 March 2014, Kukjin Kim wrote:
> > > > > > Kukjin Kim wrote:
> > > > > > > On 03/19/14 13:01, Mike Turquette wrote:
> > > > > > > 
> > > > > > > Thanks :-)
> > > > > > > 
> > > > > > > > Acked-by: Mike Turquette<mturquette@linaro.org>
> > > > > > > 
> > > > > > > It's time. Please pull this [5/6] and "[GIT PULL 6/6] Samsung
> > > > > > > clk-s3c24xx updates for v3.15".
> > > > > > 
> > > > > > Hi Arnd, Olof and Mike,
> > > > > > 
> > > > > > Still I cannot see this in arm-soc. Any problems?
> > > > > 
> > > > > Sorry, I didn't have this one on my radar any more, merged into
> > > > > next/drivers now.
> > > > 
> > > > maybe you could also take a look at the depending "[GIT PULL 6/6]
> > 
> > Samsung
> > 
> > > > clk-
> > > > s3c24xx updates for v3.15" we walked about at the beginning of the
> > > > week? :-)
> > > 
> > > Yeah, so I've informed that [5/6] and [6/6] is needed...
> > > 
> > > Arnd, Olof and Mike,
> > > 
> > > Probably you guys missed "[6/6] Samsung clk-s3c24xx updates" when
> > 
> > dependency
> > 
> > > with [5/6] has been cleared but since it's already 3.15 merge window,
> > 
> > I'm
> > 
> > > not sure it can be sent to Linus in this time...
> > 
> > Both PRs were Acked by me, so no problems from my end. Pretty late for
> > 3.15 though.
> 
> Yeah, I know. I mean 'Arnd, Olof and Kevin' ;-)
> 
> BTW, hmm...I know, it's too late for v3.15...so...unfortunately maybe I
> should queue it for v3.16?...

I guess this would be the best option. I should also be able to finish the 
s3c2410/2440/2442 conversion until then, which needs a bit more work.


Heiko
