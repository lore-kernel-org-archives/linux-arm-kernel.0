From: dianders@chromium.org (Doug Anderson)
Date: Wed, 10 Sep 2014 13:03:28 -0700
Subject: [PATCH v3 7/7] ARM: exynos_defconfig: Enable MAX77802
In-Reply-To: <1410344391-5675-8-git-send-email-javier.martinez@collabora.co.uk>
References: <1410344391-5675-1-git-send-email-javier.martinez@collabora.co.uk>
 <1410344391-5675-8-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=UL8gUO7bGk4vxZxuUuwZumzNZsR5+DVXafB6Z7Psc2kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Wed, Sep 10, 2014 at 3:19 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> From: Vivek Gautam <gautam.vivek@samsung.com>
>
> Enabled MAX77802 pmic for exynos systems.
> One config USB_ANNOUNCE_NEW_DEVICES to display device
> information on connect.
> Another config for I2C_CHARDEV to see i2c device nodes.
>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/configs/exynos_defconfig | 3 +++
>  1 file changed, 3 insertions(+)

I've no complaints about any of that.

Reviewed-by: Doug Anderson <dianders@chromium.org>
