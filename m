From: mykofzone@gmail.com (=?GB2312?B?seXA2g==?=)
Date: Mon, 7 Nov 2011 17:33:31 +0800
Subject: OMAP3 ISP DMA status
Message-ID: <CAORxB+CUEi-bykNky9T+nBOiV7mBpXnEv_uzfS=McxUdTeODSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ALL,
   I meet a problem when developing scan device (such as a camera)
driver on OMAP3 platform (my MPU is AM3715). The scan application may
change the scan hardware settings (such as exposure time), and try to
find out the best one. But sometimes, after applied the new settings,
the scan hardware may did not output data, so the application blocked.
Since i can't modify the application, the driver should notify this
event to app. So my question is that, can the driver query the ISP DMA
status such as how many bytes the DMA has transferred?

BRs,
Lei.Bian
