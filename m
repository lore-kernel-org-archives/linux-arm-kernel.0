From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Mon, 13 Dec 2010 15:15:26 +0000
Subject: [PATCHv4] regulator: support PMIC mc13892
In-Reply-To: <1292231217-4121-2-git-send-email-yong.shen@freescale.com>
References: <1292231217-4121-1-git-send-email-yong.shen@freescale.com>
	<1292231217-4121-2-git-send-email-yong.shen@freescale.com>
Message-ID: <1292253326.3320.82.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-12-13 at 17:06 +0800, yong.shen at freescale.com wrote:
> From: Yong Shen <yong.shen@linaro.org>
> 
> add support for mc13892, tested on mx51 babbage board
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Signed-off-by: Yong Shen <yong.shen@linaro.org>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/regulator/Kconfig             |    8 +
>  drivers/regulator/Makefile            |    1 +
>  drivers/regulator/mc13892-regulator.c |  635 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/mc13892.h           |   39 ++
>  4 files changed, 683 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/regulator/mc13892-regulator.c
>  create mode 100644 include/linux/mfd/mc13892.h
> 

Applied.

Can you check regulator for-next as one of your previous patches may
have been missed.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
