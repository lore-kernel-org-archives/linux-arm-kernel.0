From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 9 Apr 2013 10:06:53 +0200
Subject: [PATCH 08/10] drivers: mfd: use module_platform_driver_probe()
In-Reply-To: <1363266691-15757-10-git-send-email-fabio.porcedda@gmail.com>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <1363266691-15757-10-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <20130409080653.GG24058@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, Mar 14, 2013 at 02:11:29PM +0100, Fabio Porcedda wrote:
> This patch converts the drivers to use the
> module_platform_driver_probe() macro which makes the code smaller and
> a bit simpler.
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/mfd/davinci_voicecodec.c | 12 +-----------
>  drivers/mfd/htc-pasic3.c         | 13 +------------
>  2 files changed, 2 insertions(+), 23 deletions(-)
Jingoo Han sent a larger patchset to convert many MFD drivers to
module_platform_driver_probe(), including htc-pasic3 and davinci_voicecodec.

See my mfd-next tree for more details.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
