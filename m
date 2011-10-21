From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Oct 2011 23:25:12 +0100
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <2460374.AAkEFv9LMo@wuerfel>
References: <4E97A601.1020005@gmail.com> <2901028.94TxBXiCYq@wuerfel>
	<20111021183352.GI21648@n2100.arm.linux.org.uk>
	<2460374.AAkEFv9LMo@wuerfel>
Message-ID: <20111021222512.GJ21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2011 at 09:31:46PM +0200, Arnd Bergmann wrote:
> Ok, that is a very useful documentation, but the part I still don't
> understand is how I should get the commit ID of the stable branches.

I'll publish the branch itself.

> I noticed that you are publishing an l2x0 branch now, in addition
> to the pm and smp branches that were already there the last time
> I looked, but you don't publish the gpio, io and debug branches
> that I have pulled into the arm-soc/next-soc branch because imx6 and
> highbank depend on them.

debug has been published for a while but not the other two.  gpio can
be done trivially, but (as I've already said) io has an additional
commit on top which I'm not publishing yet.  So I'd need to fudge stuff
in some way to publish that one.

Given the time now, I'm not going to change my tree at this point,
with very little time available before having to leave.
