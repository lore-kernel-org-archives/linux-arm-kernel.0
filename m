From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 16 Mar 2018 07:47:31 +0100
Subject: [PATCH] ARM: dts: sun7i: Add pinmux settings for LCD0 RGB888
 output.
In-Reply-To: <1521121410-17103-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1521121410-17103-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180316064731.muiw5yumhmfnwxg2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Giulio,

On Thu, Mar 15, 2018 at 02:43:30PM +0100, Giulio Benetti wrote:
> The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
> for the needed pins.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Like we discussed last time, we only merge this kind of patches if
there's an immediate user.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180316/7f926caa/attachment.sig>
