From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 14 Feb 2011 08:19:06 -0700
Subject: [git pull] Revert arm/dt documentation change that shouldn't have
	been merged yet
Message-ID: <AANLkTi=dX4EjrF6qxw3oPOEJoV1PgrpiQimB=mSEzkBa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I included a patch I shouldn't have in my last pull req.  This pull
req reverts it.  Thanks to Russell for pointing it out to me.

g.


The following changes since commit 795abaf1e4e188c4171e3cd3dbb11a9fcacaf505:

  klist: Fix object alignment on 64-bit. (2011-02-13 16:54:24 -0800)

are available in the git repository at:
  git://git.secretlab.ca/git/linux-2.6 devicetree/merge

Grant Likely (1):
      Revert "dt: add documentation of ARM dt boot interface"

 Documentation/arm/Booting                       |   33 ++----------------
 Documentation/devicetree/booting-without-of.txt |   40 -----------------------
 2 files changed, 4 insertions(+), 69 deletions(-)

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
