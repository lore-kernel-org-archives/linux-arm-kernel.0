From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 27 Oct 2013 14:27:07 +0000
Subject: [PATCH v2 2/2] ARM: sun4i/sun7i: RTC driver
In-Reply-To: <1381948227-6290-2-git-send-email-carlo.caione@gmail.com>
References: <1381948227-6290-1-git-send-email-carlo.caione@gmail.com>
 <1381948227-6290-2-git-send-email-carlo.caione@gmail.com>
Message-ID: <20131027142707.GC16856@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

On Wed, Oct 16, 2013 at 08:30:27PM +0200, Carlo Caione wrote:
> This patch introduces the driver for the RTC in the Allwinner A10 and
> A20 SoCs.
> 
> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
> ---
> v1->v2:
> - Patch split in two
> - Fix coding style
> - New driver description
> - Rework macros
> - Add comments
> - Change while in for cycles
> ---
>  drivers/rtc/Kconfig     |   7 +
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-sunxi.c | 487 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 495 insertions(+)
>  create mode 100644 drivers/rtc/rtc-sunxi.c

Oh, and you forgot to add the DT bindings documentation in your patch.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131027/53b0a0ed/attachment.sig>
