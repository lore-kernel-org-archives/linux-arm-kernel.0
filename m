From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Mar 2014 20:35:15 -0300
Subject: USB OTG on mx51
Message-ID: <CAOMZO5Cpap7atPOSHSKdUgcsnZrmG=Q5REhyn6UOq=M-aGNX2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis/Eric,

Have you managed to get USB OTG functional on the eukrea-cpuimx51 board?

USB host1 works fine on mx51evk with this patch:
http://pastebin.com/Z2FYSW8m

,but g_ether is not working on the USB OTG port yet. It is like the PC
does not notice that  the USB cable has been inserted.

Do we need to change usbmisc_imx.c ?

Any ideas?

Thanks,

Fabio Estevam
