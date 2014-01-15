From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Jan 2014 13:56:45 +0800
Subject: [PATCH V3] ARM: dts: imx6sl: add keypad support for i.mx6sl-evk
 board.
In-Reply-To: <1389691828-27000-1-git-send-email-b20788@freescale.com>
References: <1389691828-27000-1-git-send-email-b20788@freescale.com>
Message-ID: <20140115055643.GE1896@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 05:30:28PM +0800, Anson Huang wrote:
> i.MX6SL EVK board has a 3*3 keypad matrix to support 8 keypads,
> enable them, the keymap is as below:
> 
> SW6:  MATRIX_KEY(0x0, 0x0, KEY_UP)         /* ROW0, COL0 */
> SW7:  MATRIX_KEY(0x0, 0x1, KEY_DOWN)       /* ROW0, COL1 */
> SW8:  MATRIX_KEY(0x0, 0x2, KEY_ENTER)      /* ROW0, COL2 */
> SW9:  MATRIX_KEY(0x1, 0x0, KEY_HOME)       /* ROW1, COL0 */
> SW10: MATRIX_KEY(0x1, 0x1, KEY_RIGHT)      /* ROW1, COL1 */
> SW11: MATRIX_KEY(0x1, 0x2, KEY_LEFT)       /* ROW1, COL2 */
> SW12: MATRIX_KEY(0x2, 0x0, KEY_VOLUMEDOWN) /* ROW2, COL0 */
> SW13: MATRIX_KEY(0x2, 0x1, KEY_VOLUMEUP)   /* ROW2, COL1 */
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.
