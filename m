From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 14 Jul 2018 13:09:59 -0300
Subject: [PATCH V2] ARM: dts: imx6sl-evk: add missing GPIO iomux setting
In-Reply-To: <1531533238-8816-1-git-send-email-Anson.Huang@nxp.com>
References: <1531533238-8816-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5AcJSMyh3Y51K+4P2Ha-aX9kbeZCT6gFN9tV90p-6F2hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Fri, Jul 13, 2018 at 10:53 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> On i.MX6SL EVK board, the MX6SL_PAD_KEY_ROW5 pin is
> used as lcd 3v3 regulator control pin, need to make
> sure MX6SL_PAD_KEY_ROW5 is muxed as GPIO function
> for controlling lcd 3v3 regulator.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Looks good now, thanks:

Reviewed-by; Fabio Estevam <fabio.estevam@nxp.com>
