From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 1 Nov 2013 14:08:35 +0100
Subject: [RESEND PATCH 2/4] i2c: i2c-bcm-kona: Add support for high-speed
 mode
In-Reply-To: <1381960909-1735-3-git-send-email-tim.kryger@linaro.org>
References: <1381960909-1735-1-git-send-email-tim.kryger@linaro.org>
 <1381960909-1735-3-git-send-email-tim.kryger@linaro.org>
Message-ID: <20131101130835.GC6734@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 03:01:47PM -0700, Tim Kryger wrote:
> Add support for I2C high-speed mode (3.4 MHz).
> 
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>

Mostly good as well:

> +enum hs_bus_speed_index {
> +	BCM_SPD_3P4MHZ = 0,
> +};

I just realized that you should update both patches to add the supported
bus speeds to the binding documentation.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131101/4fa35ef6/attachment.sig>
