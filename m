From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 2 Oct 2012 17:36:34 +0100
Subject: make dtbs in linus/master
Message-ID: <alpine.DEB.2.02.1210021725320.29232@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I am testing linus/master after the recent merge with the arm-soc tree
and I find that if I choose:

ARM system type
  1. Allow multiple platforms to be selected (ARCH_MULTIPLATFORM) (NEW)
  2. ARM Ltd. Integrator family (ARCH_INTEGRATOR)
  3. ARM Ltd. RealView family (ARCH_REALVIEW)
>  4. ARM Ltd. Versatile family (ARCH_VERSATILE)

in my kernel config, then "make dtbs" doesn't work.
However if I choose ARCH_MULTIPLATFORM then it works properly.

Is it expected?

Cheers,

Stefano
