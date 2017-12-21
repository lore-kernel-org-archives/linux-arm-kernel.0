From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 21 Dec 2017 16:22:57 +0800
Subject: [PATCH v3 1/3] ARM: dts: imx6sx-sdb: Convert from fbdev to drm
 bindings
In-Reply-To: <1512573319-6624-1-git-send-email-marcofrk@gmail.com>
References: <1512573319-6624-1-git-send-email-marcofrk@gmail.com>
Message-ID: <20171221082256.GN23230@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 01:15:17PM -0200, Marco Franchi wrote:
> It is preferred to use the panel compatible string rather than passing
> the LCD timing in the device tree.
> 
> So pass the "sii,43wvf1g" compatible string, which describes the parallel
> LCD.
> 
> Also pass the 'backlight' property as described in
> Documentation/devicetree/bindings/display/panel/simple-panel.txt
> 
> Signed-off-by: Marco Franchi <marcofrk@gmail.com>

Applied all, thanks.
