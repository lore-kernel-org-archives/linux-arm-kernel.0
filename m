From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 5 Jan 2012 20:48:02 +0800
Subject: [PATCH] ARM: mx28: Let audio support be built by default
In-Reply-To: <1325169961-11923-1-git-send-email-festevam@gmail.com>
References: <1325169961-11923-1-git-send-email-festevam@gmail.com>
Message-ID: <20120105124801.GA15286@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2011 at 12:46:01PM -0200, Fabio Estevam wrote:
> Let audio support be built by default.
> 
> As sgtl5000 codec is connected via I2C, let MXS I2C driver also be built
> by default.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/configs/mxs_defconfig |   19 ++++++++++++++++---
>  1 files changed, 16 insertions(+), 3 deletions(-)
> 
The changes are not sufficient for audio to work.
CONFIG_REGULATOR_FIXED_VOLTAGE is needed too.

-- 
Regards,
Shawn
