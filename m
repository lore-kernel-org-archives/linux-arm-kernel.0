From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 5 Feb 2010 07:48:09 +0100
Subject: [PATCHv2 11/11] mxc: Add imx51_defconfig
In-Reply-To: <23d720d71fcb0d088fa1829fccaa4823090e1346.1265173480.git.amit.kucheria@canonical.com>
References: <cover.1265173480.git.amit.kucheria@canonical.com>
	<23d720d71fcb0d088fa1829fccaa4823090e1346.1265173480.git.amit.kucheria@canonical.com>
Message-ID: <20100205064809.GZ6130@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit,

On Tue, Feb 02, 2010 at 09:16:33PM -0800, Amit Kucheria wrote:
> This config is used to test the base support for i.MX51 processors on the
> Babbage board
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
> ---
>  arch/arm/configs/imx51_defconfig | 1286 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 1286 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/configs/imx51_defconfig

Can you rename this to mx51_defconfig? All other i.MX defconfigs begin
with mx.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
