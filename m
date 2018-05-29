From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 29 May 2018 09:58:20 -0300
Subject: [PATCH v2 3/4] ARM: dts: imx6qdl-wandboard: enable USB OTG
In-Reply-To: <20180529062021.3154-4-akurz@blala.de>
References: <20180529062021.3154-1-akurz@blala.de>
 <20180529062021.3154-4-akurz@blala.de>
Message-ID: <CAOMZO5DW12s2d_79JUPGY3Y=G+Nizp2bB56TRm1gQHwVDQLESg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 3:20 AM, Alexander Kurz <akurz@blala.de> wrote:
> Enable USB OTG (dual-role) on the Wandboard.
> Note, that the USB_OTG_VBUS current is quite limited due to a 22R resistor
> in the power line. Hence, the overcurrent signal of 1A will never be
> triggered on this board.
>
> Signed-off-by: Alexander Kurz <akurz@blala.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
