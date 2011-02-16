From: B02280@freescale.com (Chen Jie-B02280)
Date: Wed, 16 Feb 2011 01:40:42 +0000
Subject: [PATCH 1/3] IPUv3: Add i.MX53 IPU support
In-Reply-To: <AANLkTikD-=LJB2mmxG5jnBT_YXAcKfV6g5cXEvcWF4pV@mail.gmail.com>
References: <1297760175-19211-1-git-send-email-jason.chen@freescale.com>
	<AANLkTikD-=LJB2mmxG5jnBT_YXAcKfV6g5cXEvcWF4pV@mail.gmail.com>
Message-ID: <33F32152BE7EC740BC2C838D2836AC870E64EE@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio,

You need do some cherry-pick from Sascha's ipuv3 branch to for-next.

Jason Chen / Chen Jie
NMG / MAD
Freescale Semiconductor (China) Ltd.
2F, Building B, 177#, Bi Bo Rd
Pu Dong New District Shanghai?201203
Tel:???? 021-28937178?
Fax:???? 021-28937444
E-mail:??Jason.Chen at freescale.com


-----Original Message-----
From: Fabio Estevam [mailto:festevam at gmail.com] 
Sent: Wednesday, February 16, 2011 12:12 AM
To: Chen Jie-B02280
Cc: s.hauer at pengutronix.de; linux-arm-kernel at lists.infradead.org; Chen Jie-B02280
Subject: Re: [PATCH 1/3] IPUv3: Add i.MX53 IPU support

Hi Jason,

On Tue, Feb 15, 2011 at 6:56 AM,  <jason.chen@freescale.com> wrote:
> From: Jason Chen <b02280@freescale.com>
>
> Signed-off-by: Jason Chen <b02280@freescale.com>
> ---
> ?arch/arm/mach-mx5/board-mx51_babbage.c ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-mx5/devices-imx51.h ? ? ? ? ? ? ? | ? ?3 -
> ?arch/arm/plat-mxc/devices/platform-imx_ipuv3.c ?| ? 97 
> +++++++++++++++++++++--
> ?arch/arm/plat-mxc/include/mach/devices-common.h | ? ?4 +-
> ?arch/arm/plat-mxc/include/mach/ipu-v3.h ? ? ? ? | ? ?1 +
> ?drivers/mfd/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?6 +-
> ?drivers/mfd/imx-ipu-v3/ipu-common.c ? ? ? ? ? ? | ? 66 
> +++------------
> ?drivers/mfd/imx-ipu-v3/ipu-prv.h ? ? ? ? ? ? ? ?| ? 32 ++++----
> ?8 files changed, 126 insertions(+), 85 deletions(-)

Which git tree did you use for these patches?

I can not see a git tree that contains both the MX51 IPU and MX53LOCO board support.

Regards,

Fabio Estevam
