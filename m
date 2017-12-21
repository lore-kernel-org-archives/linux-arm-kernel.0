From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 21 Dec 2017 16:29:44 +0800
Subject: [PATCH v3 1/9] ARM: dts: imx7-colibri: move and rename USB Host
 power regulator
In-Reply-To: <20171219181038.1369-1-stefan@agner.ch>
References: <20171219181038.1369-1-stefan@agner.ch>
Message-ID: <20171221082943.GO23230@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 07:10:30PM +0100, Stefan Agner wrote:
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
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied all, thanks.
