From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Jan 2015 16:05:31 +0100
Subject: [PATCH 2/6] bus: mvebu-mbus: fix support of MBus window 13 on
 Armada XP/375/38x
In-Reply-To: <20150119222930.GF2938@lunn.ch>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1419943428-18491-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150119222930.GF2938@lunn.ch>
Message-ID: <20150120160531.481476a8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 19 Jan 2015 23:29:30 +0100, Andrew Lunn wrote:

> > [Thomas: adapted for the mainline kernel, minor clarifications in the
> > code, reword the commit log.]
> > 
> > Fixes: fddddb52a6c ("bus: introduce an Marvell EBU MBus driver")
> > Cc: <stable@vger.kernel.org> # v3.10+
> > Signed-off-by: Michal Mazur <arg@semihalf.com>
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> I merged in the revert of the simple fix for window 13. So the end
> patch is below.
> 
> merged into mvebu/soc

Quickly looked at it, it looks fine to me.

Thanks again for handling this!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
