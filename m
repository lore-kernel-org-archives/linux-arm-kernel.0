From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Mar 2014 13:55:16 +0100
Subject: [GIT PULL V2] ARM: mvebu: dt changes for v3.15 (incr. pull #3)
In-Reply-To: <20140317142330.GG15608@titan.lakedaemon.net>
References: <20140301052536.GS1872@titan.lakedaemon.net>
 <201403171111.30596.arnd@arndb.de>
 <20140317142330.GG15608@titan.lakedaemon.net>
Message-ID: <201403181355.16350.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 March 2014, Jason Cooper wrote:
> On Mon, Mar 17, 2014 at 11:11:30AM +0100, Arnd Bergmann wrote:
> > On Tuesday 04 March 2014, Jason Cooper wrote:
> > Pulled into next/dt now, along with the #4 and #5. I got a trivial
> > merge conflict against the dts Makefile change from mach-qcom and
> > noticed that splitting up the dtb section into per-soc breaks
> > alphabetical ordering, which I changed in the merge by moving
> > it down to the end of the list.
> 
> Ok, I was trying to reduce conflicts by leaving things in place, then
> do a fixes-non-critical patch to put things back in alphabetical order
> after the dust had settled.

Ah, that was clearly a better plan than what I did. I actually mismerged
things at first and then spent some time cleaning it all up again.

	Arnd
