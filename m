From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Dec 2011 21:20:48 +0000
Subject: [GIT PULL] sa1100 fixes for 3.2
In-Reply-To: <201112081649.23956.arnd@arndb.de>
References: <CAN1soZyDCb8BqjTZ3N7kJBspQQtGuBchQYRbr2qcY1J24zCfuw@mail.gmail.com>
 <201112081649.23956.arnd@arndb.de>
Message-ID: <20111208212048.GL14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 04:49:23PM +0000, Arnd Bergmann wrote:
> I'm a bit confused about who I should be pulling from pxa and mmp stuff
> in general. I've taken the liberal approach so far and just pulled whatever
> gets thrown at me as long as it looks good from each of you, but the
> MAINTAINERS file currently lists:
> 
> PXA2xx/PXA3xx SUPPORT
> M:      Eric Miao <eric.y.miao@gmail.com>
> M:      Russell King <linux@arm.linux.org.uk>
> PXA168 SUPPORT
> M:      Eric Miao <eric.y.miao@gmail.com>
> M:      Jason Chagas <jason.chagas@marvell.com>
> PXA910 SUPPORT
> M:      Eric Miao <eric.y.miao@gmail.com>
> MMP2 SUPPORT (aka ARMADA610)
> M:      Haojian Zhuang <haojian.zhuang@marvell.com>
> M:      Eric Miao <eric.y.miao@gmail.com>
> 
> Should that be updated to include you for all of these? I certainly don't
> want to step on Eric's and Russell's toes but you seem to be doing the bulk
> of the pxa/mmp work nowadays and I would prefer to pull from someone
> who is actually listed as maintainer.

Eric no longer works for Marvell, but does what he can to look after PXA
stuff.  I can't really claim to be a 'maintainer' for PXA, but I still do
some work in this area mostly in an advisory role.

Jason doesn't seem to be contactable by any means (even his personal
cell phone number and work number don't get him - though I do get his
voicemail) and I've been worried about this for a number of months -
even Haojian seems unable to contact Jason.

Haojian is now the contact within Marvell for PXA/MMP stuff, so can be
regarded as valid to pull from.

If Haojian wishes to send a patch adding to the MAINTAINERS entries as
appropriate, then I'd support that.
