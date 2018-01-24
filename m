From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 24 Jan 2018 07:28:30 +0100
Subject: [v2,2/5] i2c: meson: add configurable divider factors
In-Reply-To: <20171120145415.6581-3-yixun.lan@amlogic.com>
References: <20171120145415.6581-3-yixun.lan@amlogic.com>
Message-ID: <20180124062830.vi52rtlgglryq3xz@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 10:54:12PM +0800, Yixun Lan wrote:
> From: Jian Hu <jian.hu@amlogic.com>
> 
> This patch try to add support for I2C controller in Meson-AXG SoC,
> Due to the IP changes between I2C controller, we need to introduce
> a compatible data to make the divider factor configurable.
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Applied to for-next, thanks!

But I got two build warnings, please fix them with an incremental patch:

drivers/i2c/busses/i2c-meson.c:103: warning: No description found for parameter 'data'
drivers/i2c/busses/i2c-meson.c:103: warning: Excess struct member 'irq' description in 'meson_i2c'

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180124/7f3691f4/attachment-0001.sig>
