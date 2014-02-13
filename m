From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 13 Feb 2014 10:17:50 +0800
Subject: [PATCH V2 1/2] ARM: dts: imx6q: add 852MHz setpoint for CPU freq
In-Reply-To: <1392199023-29880-1-git-send-email-b20788@freescale.com>
References: <1392199023-29880-1-git-send-email-b20788@freescale.com>
Message-ID: <20140213021748.GD950@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 05:57:02PM +0800, Anson Huang wrote:
> According to datasheet, i.MX6Q has setpoint of 852MHz
> which is exclusive with 996MHz, the fuse map of speed_grading
> defines the max speed of ARM, here we add this 852MHz
> setpoint opp info, kernel will check the speed_grading
> fuse and remove all illegal setpoints.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied both, thanks.
