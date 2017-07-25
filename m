From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 25 Jul 2017 16:43:10 +0800
Subject: [PATCH v2] ARM: imx_v6_v7_defconfig: Enable staging video4linux
 drivers
In-Reply-To: <1500247602-3364-1-git-send-email-festevam@gmail.com>
References: <1500247602-3364-1-git-send-email-festevam@gmail.com>
Message-ID: <20170725084308.GG20064@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 16, 2017 at 08:26:42PM -0300, Fabio Estevam wrote:
> From: Steve Longerbeam <steve_longerbeam@mentor.com>
> 
> Enable i.MX v4l2 media staging driver. For video capture on i.MX, the
> video multiplexer subdev is required. On the SabreAuto, the ADV7180
> video decoder is required along with i2c-mux-gpio. The Sabrelite
> and SabreSD require the OV5640 and the SabreLite requires PWM clocks
> for the OV5640.
> 
> Increase max zoneorder to allow larger video buffer allocations.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
