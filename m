From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 17 Jul 2018 14:48:16 +0800
Subject: [PATCH V2] ARM: dts: imx6sl-evk: add missing GPIO iomux setting
In-Reply-To: <1531533238-8816-1-git-send-email-Anson.Huang@nxp.com>
References: <1531533238-8816-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180717064815.GL4576@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 14, 2018 at 09:53:58AM +0800, Anson Huang wrote:
> On i.MX6SL EVK board, the MX6SL_PAD_KEY_ROW5 pin is
> used as lcd 3v3 regulator control pin, need to make
> sure MX6SL_PAD_KEY_ROW5 is muxed as GPIO function
> for controlling lcd 3v3 regulator.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
