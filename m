From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 10 Dec 2017 13:14:17 -0200
Subject: [PATCH v1 2/6] ARM: dts: imx7d-cl-som: add nodes for usbh,
 and usbotg2
In-Reply-To: <20171205222707.11302-3-tyler@opensourcefoundries.com>
References: <20171205222707.11302-1-tyler@opensourcefoundries.com>
 <20171205222707.11302-3-tyler@opensourcefoundries.com>
Message-ID: <CAOMZO5DKLT4YtzS9pxCU3O9ToCRUMXJhZZsQ71LhnOdORkYM5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 8:27 PM,  <tyler@opensourcefoundries.com> wrote:
> From: Tyler Baker <tyler@opensourcefoundries.com>
>
> Add device tree nodes for the USB hub, and USB OTG. i2c2 on this
> platform supports low state retention power state so lets use it.

Looks like the I2C2 fix should be a separate patch.
