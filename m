From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 29 Jun 2017 17:57:46 +0200
Subject: [PATCH v7] drm/sun4i: hdmi: Implement I2C adapter for A10s DDC bus
In-Reply-To: <20170628105224.6619-1-net147@gmail.com>
References: <20170628105224.6619-1-net147@gmail.com>
Message-ID: <20170629155746.ux5embr7tdo7k4xr@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 28, 2017 at 08:52:24PM +1000, Jonathan Liu wrote:
> The documentation for drm_do_get_edid in drivers/gpu/drm/drm_edid.c states:
> "As in the general case the DDC bus is accessible by the kernel at the I2C
> level, drivers must make all reasonable efforts to expose it as an I2C
> adapter and use drm_get_edid() instead of abusing this function."
> 
> Exposing the DDC bus as an I2C adapter is more beneficial as it can be used
> for purposes other than reading the EDID such as modifying the EDID or
> using the HDMI DDC pins as an I2C bus through the I2C dev interface from
> userspace (e.g. i2c-tools).
> 
> Implement this for A10s.
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>

Please wait before the discussion stops before sending the new
version. We still have one ongoing on the v5, and you sent v6 and v7
in between.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170629/9448c258/attachment.sig>
