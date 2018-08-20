From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 20 Aug 2018 13:01:02 -0300
Subject: [PATCH] ARM: dts: imx6: Add stdout-path to Wandboard
In-Reply-To: <20180814204758.3049-1-tuomas@tuxera.com>
References: <20180814204758.3049-1-tuomas@tuxera.com>
Message-ID: <CAOMZO5A2U5vZkfCE7xaMfrTQCogBojBDAWUe3XDCr7-JipD2Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tuomas,

On Tue, Aug 14, 2018 at 5:47 PM, Tuomas Tynkkynen <tuomas@tuxera.com> wrote:
> Setting a stdout-path in the .dtb is convenient because then the user
> gets a serial console on the RS-232 connector without any extra effort
> of figuring out the relevant 'console=' boot parameter.
>
> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>

Patch looks good.

Only a minor nit on the Subject line: I would do it like this to make
it consistent:

ARM: dts: imx6qdl-wandboard: Add stdout-path

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
