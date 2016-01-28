From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 28 Jan 2016 16:45:31 +0800
Subject: [PATCH] ARM: dts: imx: ventana: add alternate PWM4 pinmux for
 GW54xx
In-Reply-To: <1452189489-22515-1-git-send-email-tharvey@gateworks.com>
References: <1452189489-22515-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20160128084531.GS9070@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 09:58:09AM -0800, Tim Harvey wrote:
> The GW54xx can provide PWM4 out either the off-board backlight connector
> or the off-board digital I/O connector. By default the pinmux routes it
> to the backlight connector but this pinctl alternate provides documentation
> for those who may want to change it.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
