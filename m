From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Jan 2017 14:02:52 -0200
Subject: imx6: PCIe imx6_pcie_assert_core_reset() hangs after watchdog
 reset
In-Reply-To: <1484835887.24339.40.camel@pengutronix.de>
References: <1427377198.3378.16.camel@pengutronix.de>
 <20161106153117.GA22538@frolo.macqel>
 <CAOMZO5ADK9TvQiBs8HrKjNp+avZsO9xujZvG6CO2onZdAcDSGA@mail.gmail.com>
 <1478514883.12872.2.camel@pengutronix.de>
 <CAOMZO5C+3rCnpQvonXyDaMmUxsDYAnXRBXrUwbP3AT5TbofSgQ@mail.gmail.com>
 <1484835887.24339.40.camel@pengutronix.de>
Message-ID: <CAOMZO5C0tOmhZpKsVFCXfxsOFf8hDM1uZVdRnNkHUBuUJrYa+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Thu, Jan 19, 2017 at 12:24 PM, Lucas Stach <l.stach@pengutronix.de> wrote:

> Did you have some time to validate/fix this in U-Boot? I would like to
> get the workaround removed from the kernel.

Just saw your kernel patch. I haven't had a chance to fix this in
U-Boot yet, but I plan to do it soon.
