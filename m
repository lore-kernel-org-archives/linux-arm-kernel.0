From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 5 Nov 2015 19:45:32 +0100
Subject: [PATCH 0/2] [media] c8sectpfe: Deletion of a few unnecessary checks
In-Reply-To: <5317A59D.4@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
Message-ID: <563BA3CC.4040709@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 5 Nov 2015 19:39:32 +0100

Another update suggestion was taken into account after a patch was applied
from static source code analysis.

Markus Elfring (2):
  Delete unnecessary checks before two function calls
  Combine three checks into a single if block

 drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.6.2
