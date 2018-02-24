From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Feb 2018 17:20:12 +0800
Subject: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
In-Reply-To: <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
References: <1519459369-29083-1-git-send-email-Anson.Huang@nxp.com>
 <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180224092011.GR3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 24, 2018 at 04:02:49PM +0800, Anson Huang wrote:
> This patch adds i.MX7 thermal sensor support, most
> of the i.MX7 thermal sensor functions are same with
> i.MX6 except the registers offset/layout, so we move
> those registers offset/layout definitions to soc data
> structure.
> 
> i.MX7 uses single calibration data @25C, the calibration
> data is located at OCOTP offset 0x4F0, bit[17:9], the
> formula is as below:
> 
> Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
