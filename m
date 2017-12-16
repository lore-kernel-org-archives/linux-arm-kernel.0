From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 16 Dec 2017 12:00:20 -0200
Subject: [PATCH 1/9] ARM: dts: imx7-colibri: move and rename USB Host
 power regulator
In-Reply-To: <20171206153005.6144-1-stefan@agner.ch>
References: <20171206153005.6144-1-stefan@agner.ch>
Message-ID: <CAOMZO5Ak+F7KMvYYDfGrWx-LzPMQGYpfyes7Nz=mgZKSQ_ZV_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 1:29 PM, Stefan Agner <stefan@agner.ch> wrote:
> The Colibri default which enables USB Host power is not necessarily
> tied to the OTG2 controller, some carrier board use the pin to
> control USB power for both controllers. Hence name the pinctrl
> group more generic.
>
> Also move the regulator to the generic eval-v3 device tree since
> the regulator is always on the carrier board. In the Colibri iMX7S
> case the regulator is just not used.  This allows to reuse the
> regulator in a upcoming SKU Colibri iMX7D 1GB with eMMC.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
