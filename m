From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 12 Mar 2015 08:49:02 +0100
Subject: [PATCH] backlight: pwm: handle EPROBE_DEFER while requesting the
 PWM
In-Reply-To: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
References: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150312074859.GA30344@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 10:30:14AM +0100, Nicolas Ferre wrote:
> When trying to request the PWM device with devm_pwm_get(), the EPROBE_DEFER
> flag is not handled properly. It can lead to the PWM not being found.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150312/483429d4/attachment-0001.sig>
