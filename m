From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Oct 2011 21:31:46 +0200
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <20111021183352.GI21648@n2100.arm.linux.org.uk>
References: <4E97A601.1020005@gmail.com> <2901028.94TxBXiCYq@wuerfel>
	<20111021183352.GI21648@n2100.arm.linux.org.uk>
Message-ID: <2460374.AAkEFv9LMo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 October 2011 19:33:52 Russell King - ARM Linux wrote:
> On Thu, Oct 20, 2011 at 11:04:35PM +0200, Arnd Bergmann wrote:
> > I'm not sure if I used the intended process to get at those branches.
> > Since they are not published on ftp.arm.linux.org.uk as separate branches,
> > I looked at the big merge changeset in the for-next branch and recreated
> > the branches I needed, which feels like I'm doing something that wasn't
> > your intention. Is there a better way?
> 
> The best way is to say "Hey, my work depends on X, Y, Z" and I'll see
> what can be done to make them stable and say whether they are ripe
> for that yet (or, eg, whether they're waiting for peoples acks.)
> 
> It's actually what I documented a while ago at
> http://www.arm.linux.org.uk/developer/git-arm.php

Ok, that is a very useful documentation, but the part I still don't
understand is how I should get the commit ID of the stable branches.
I noticed that you are publishing an l2x0 branch now, in addition
to the pm and smp branches that were already there the last time
I looked, but you don't publish the gpio, io and debug branches
that I have pulled into the arm-soc/next-soc branch because imx6 and
highbank depend on them.

Does that mean you don't consider the latter three branches stable
yet, or does it just mean they are stable but you had no reason
to publish them?

	Arnd
