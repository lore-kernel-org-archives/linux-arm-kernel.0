From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Nov 2012 19:00:53 -0200
Subject: [PATCH] ARM: imx: Move platform-mx2-emma to
 arch/arm/mach-imx/devices
In-Reply-To: <1353946282-12439-1-git-send-email-fabio.estevam@freescale.com>
References: <1353946282-12439-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <CAOMZO5DzXgC-pX581vJzc81JO9XX2HmJaUyrDgZ0OKGS9L43iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Nov 26, 2012 at 2:11 PM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> Move platform-mx2-emma to arch/arm/mach-imx/devices and fix the following build
> error:
>
> make[2]: *** No rule to make target `arch/arm/mach-imx/devices/platform-mx2-emma.o', needed by `arch/arm/mach-imx/devices/built-in.o'.  Stop.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Could this one be applied, so that linux-next can be built again form
imx_v4_v5_defconfig?

Regards,

Fabio Estevam
