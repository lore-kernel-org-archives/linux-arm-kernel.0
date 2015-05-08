From: otavio@ossystems.com.br (Otavio Salvador)
Date: Fri, 8 May 2015 09:42:46 -0300
Subject: [PATCH 3/3] ARM: dts: imx6sl-warp: Fix OTG roles
In-Reply-To: <1430434530-12605-3-git-send-email-festevam@gmail.com>
References: <1430434530-12605-1-git-send-email-festevam@gmail.com>
 <1430434530-12605-3-git-send-email-festevam@gmail.com>
Message-ID: <CAP9ODKo5gmeLccGx1dNY6hmBN6NDXY3mXRk0S1RZ3w3Sg=NNyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 7:55 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> USBOTG1 always work on peripheral mode and USBOTG in host mode, so fix
> their roles accordingly.
>
> Tested by mounting the MMC card as a storage device:
>
> modprobe g_mass_storage file=/dev/mmcblk0p2
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Otavio Salvador <otavio@ossystems.com.br>

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
