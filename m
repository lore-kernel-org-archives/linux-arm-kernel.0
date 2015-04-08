From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 8 Apr 2015 10:32:06 -0300
Subject: imx6: PCIe imx6_pcie_assert_core_reset() hangs after watchdog
 reset
In-Reply-To: <55128016.3030903@denx.de>
References: <55128016.3030903@denx.de>
Message-ID: <CAOMZO5CDOJXp3Hbe8a9dPh=krWhw-i5i8Zoa5Hb+2XGAdou7ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Wed, Mar 25, 2015 at 6:29 AM, Stefan Roese <sr@denx.de> wrote:
> Hi!
>
> I'm currently facing a problem in the imx6 PCIe driver. The
> problem happens, after the Linux imx6 internal watchdog has timed-out
> and issues a reset (this is intended, as I'm testing this wdog right
> now). But the next Linux boot hangs in imx6_pcie_assert_core_reset()
> while accessing a register from the PCIe port logic memory:

I am not able to reproduce this problem on a imx6q-sabresd.

Even with PCI enabled in U-boot, when I run 'reboot' the kernel
re-starts fine here.

Regards,

Fabio Estevam
