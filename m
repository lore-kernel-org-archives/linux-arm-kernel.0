From: nm@ti.com (Nishanth Menon)
Date: Tue, 16 Jul 2013 11:41:08 -0500
Subject: [PATCH V2 0/2] regulator: palmas-pmic: doc: update device tree
 bindings
In-Reply-To: <20130716161939.GR22506@sirena.org.uk>
References: <20130716161939.GR22506@sirena.org.uk>
Message-ID: <1373992870-20725-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We seem to have a few missing updates to device tree bindings with the
latest set of changes getting merged in.

Changes since V1:
	Apologies on the spam, looks like I got the wrong mail ID first time around :(
	minor commit message cleanups

V1: http://marc.info/?l=linux-doc&m=137398467901450&w=2

Based on v3.11-rc1 tag

Nishanth Menon (2):
  regulator: palmas-pmic: doc: fix typo for sleep-mode
  regulator: palmas-pmic: doc: remove ti,tstep

 .../devicetree/bindings/regulator/palmas-pmic.txt  |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
1.7.9.5

Regards,
Nishanth Menon
