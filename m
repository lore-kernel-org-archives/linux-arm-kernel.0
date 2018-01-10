From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 10 Jan 2018 14:53:52 -0200
Subject: [PATCH 3/3] ARM: dts: imx7d-sdb: Add support for mpl3115 sensor
In-Reply-To: <1515498385-23198-3-git-send-email-marco.franchi@nxp.com>
References: <1515498385-23198-1-git-send-email-marco.franchi@nxp.com>
 <1515498385-23198-3-git-send-email-marco.franchi@nxp.com>
Message-ID: <CAOMZO5BV2hyNdRPRn8G1bN6YKQ6vwnBQ5nGFR-JEQBUPuitzcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 9, 2018 at 9:46 AM, Marco Franchi <marco.franchi@nxp.com> wrote:
> The i.MX 7D SDB has a MPL3115 Pressure sensor.
> Add support for this sensor, which is included in the trivial i2c devices
> and according to the bindings documentation, just need a compatible field
> and an address.
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
