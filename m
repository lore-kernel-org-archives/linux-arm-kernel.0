From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Apr 2014 11:32:14 +0200
Subject: [GIT PULL] at91: fixes for 3.15 #1
In-Reply-To: <535B0A00.9080808@atmel.com>
References: <1397857958-11283-1-git-send-email-nicolas.ferre@atmel.com>
 <535B0A00.9080808@atmel.com>
Message-ID: <4230576.PqgF2ezODp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 April 2014 18:21:04 Nicolas Ferre wrote:
> On 18/04/2014 14:52, Nicolas Ferre :
> > Arnd, Olof, Kevin,
> > 
> > Two little fixes for AT91. The one that moves the dt-bindings include
> > directory is pretty interesting as, with Exynos, AT91 was the only one
> > to use this "clk" directory.
> > 
> > Thanks, best regards,
> > 
> > The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> > 
> >   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://github.com/at91linux/linux-at91.git tags/at91-fixes
> 
> Arnd,
> 
> It seems that this material has not been integrated in today's arm-soc
> pull-request to Linus.
> 
> Was it too late for this batch?

No, it was my mistake that it got missed. Sorry about that, I've applied
it now and will send it next time.
	
	Arnd
