From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 18 Mar 2014 09:01:29 -0400
Subject: [GIT PULL V2] ARM: mvebu: dt changes for v3.15 (incr. pull #3)
In-Reply-To: <201403181355.16350.arnd@arndb.de>
References: <20140301052536.GS1872@titan.lakedaemon.net>
 <201403171111.30596.arnd@arndb.de>
 <20140317142330.GG15608@titan.lakedaemon.net>
 <201403181355.16350.arnd@arndb.de>
Message-ID: <20140318130129.GR15608@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 01:55:16PM +0100, Arnd Bergmann wrote:
> On Monday 17 March 2014, Jason Cooper wrote:
> > On Mon, Mar 17, 2014 at 11:11:30AM +0100, Arnd Bergmann wrote:
> > > On Tuesday 04 March 2014, Jason Cooper wrote:
> > > Pulled into next/dt now, along with the #4 and #5. I got a trivial
> > > merge conflict against the dts Makefile change from mach-qcom and
> > > noticed that splitting up the dtb section into per-soc breaks
> > > alphabetical ordering, which I changed in the merge by moving
> > > it down to the end of the list.
> > 
> > Ok, I was trying to reduce conflicts by leaving things in place, then
> > do a fixes-non-critical patch to put things back in alphabetical order
> > after the dust had settled.
> 
> Ah, that was clearly a better plan than what I did. I actually mismerged
> things at first and then spent some time cleaning it all up again.

No problem, I should've been explicit in my intent from the beginning.
That would've saved you some work. ;-)

thx,

Jason.
