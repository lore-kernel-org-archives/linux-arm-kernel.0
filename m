From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 10 Jan 2018 14:51:59 -0200
Subject: [PATCH 1/3] ARM: dts: imx6ul-evk: Add support for mag3110 sensor
In-Reply-To: <1515498385-23198-1-git-send-email-marco.franchi@nxp.com>
References: <1515498385-23198-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <CAOMZO5B-_E3mpf7gU02+LAeqSpnNx75yUR-7GSOMYmoVKz3q6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 9, 2018 at 9:46 AM, Marco Franchi <marco.franchi@nxp.com> wrote:
> The i.MX 6UL EVK has a MAG3110 Magnetometer sensor in its base board.
> Add support for this sensor, which is included in the trivial i2c devices
> and according to the bindings documentation, just need a compatible field
> and an address.
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
