From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 16 Nov 2015 22:20:25 +0100
Subject: [PATCH 0/3] ste_dma40: Deletion of a few unnecessary checks
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
Message-ID: <564A4899.8040109@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Nov 2015 22:12:23 +0100

Further update suggestions were taken into account after a patch
was applied from static source code analysis.

Markus Elfring (3):
  Delete an unnecessary check before the function call "kmem_cache_destroy"
  Delete another unnecessary check in d40_probe()
  Delete an unnecessary variable initialisation in d40_probe()

 drivers/dma/ste_dma40.c | 87 ++++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 45 deletions(-)

-- 
2.6.2
