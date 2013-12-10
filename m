From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Dec 2013 20:33:00 +0100
Subject: [PATCH v4 0/9] ARM: Initial support for Marvell Berlin SoCs
In-Reply-To: <20131210191653.GA10105@quad.lixom.net>
References: <1383661723-17956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <52A674F1.7000104@gmail.com> <20131210191653.GA10105@quad.lixom.net>
Message-ID: <201312102033.00953.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 December 2013, Olof Johansson wrote:
> > I started with mach-mvebu in the first RFC, but Berlin SoCs are from a
> > different business unit at Marvell and are more PXA compatible than
> > Orion/Kirkwood/Armada 370/XP. Most notably, they lack the "mbus" and
> > IP is either from PXA/MMP or Synopsys DW. Thomas Petazzoni and also
> > Jisheng Zhang from Marvell suggested to not put it into mvebu but
> > have a different mach folder instead.
> 
> Hmm, ok. Well, maybe later on we can look at aggregating them more again. It'd
> be nice to get fewer top-level platform directories per vendor.

I possibly a lot of directories just become empty in the long run and
we remove them once all all code has been subsystemized and drivered.

	Arnd
