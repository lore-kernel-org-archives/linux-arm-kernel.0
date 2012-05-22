From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 May 2012 21:52:59 +0800
Subject: [PATCH v2 05/12] usb: chipidea: add imx driver binding
In-Reply-To: <20120522103516.GR30559@arwen.pp.htv.fi>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-6-git-send-email-richard.zhao@freescale.com>
 <201205220630.57007.marex@denx.de>
 <20120522045120.GL6206@b20223-02.ap.freescale.net>
 <87fwasbkt7.fsf@ashishki-desk.ger.corp.intel.com>
 <20120522100624.GP30559@arwen.pp.htv.fi>
 <20120522103139.GD32035@b20223-02.ap.freescale.net>
 <20120522103516.GR30559@arwen.pp.htv.fi>
Message-ID: <20120522135257.GQ8140@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 01:35:17PM +0300, Felipe Balbi wrote:
> My suggestion to Alex is to remove all dependencies for at least a
> couple of merge windows and only add dependencies for stuff which
> actually matters; like only building the PCI glue layer when CONFIG_PCI
> is defined instead of when ARCH_X86 is defined and so on.
> 
As ci13xxx_imx is a DT only driver, it needs to depend on CONFIG_OF.

-- 
Regards,
Shawn
