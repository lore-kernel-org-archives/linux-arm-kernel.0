From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 15 Feb 2011 14:12:15 -0200
Subject: [PATCH 1/3] IPUv3: Add i.MX53 IPU support
In-Reply-To: <1297760175-19211-1-git-send-email-jason.chen@freescale.com>
References: <1297760175-19211-1-git-send-email-jason.chen@freescale.com>
Message-ID: <AANLkTikD-=LJB2mmxG5jnBT_YXAcKfV6g5cXEvcWF4pV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Feb 15, 2011 at 6:56 AM,  <jason.chen@freescale.com> wrote:
> From: Jason Chen <b02280@freescale.com>
>
> Signed-off-by: Jason Chen <b02280@freescale.com>
> ---
> ?arch/arm/mach-mx5/board-mx51_babbage.c ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-mx5/devices-imx51.h ? ? ? ? ? ? ? | ? ?3 -
> ?arch/arm/plat-mxc/devices/platform-imx_ipuv3.c ?| ? 97 +++++++++++++++++++++--
> ?arch/arm/plat-mxc/include/mach/devices-common.h | ? ?4 +-
> ?arch/arm/plat-mxc/include/mach/ipu-v3.h ? ? ? ? | ? ?1 +
> ?drivers/mfd/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?6 +-
> ?drivers/mfd/imx-ipu-v3/ipu-common.c ? ? ? ? ? ? | ? 66 +++------------
> ?drivers/mfd/imx-ipu-v3/ipu-prv.h ? ? ? ? ? ? ? ?| ? 32 ++++----
> ?8 files changed, 126 insertions(+), 85 deletions(-)

Which git tree did you use for these patches?

I can not see a git tree that contains both the MX51 IPU and MX53LOCO
board support.

Regards,

Fabio Estevam
