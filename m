From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 28 Oct 2009 00:55:08 +0100
Subject: [PATCH] video: add driver for PXA3xx 2D graphics accelerator [v3]
Message-ID: <20091027235508.GZ14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric et al,

Dennis Oliver Kropp manged to find a long standing race in our PXA3xx
DirectFB accelerator driver which makes the system stable now in all our
tests. The necessary user space patch went upstream already [1].
Below is a patch that adds the corresponding kernel space driver.

We're using that driver for quite some time now and believe that it is a
huge benefit for any user of PXA3xx SoCs with graphical applications, so
we would love to see it merged upstream soon. Could this go thru the pxa
tree for .33?

Thanks,
Daniel


[1] http://git.directfb.org/?p=core/DirectFB.git;a=commit;h=01b6e0fa56aa3ceadbde8344c3f35cb4a1feab15
