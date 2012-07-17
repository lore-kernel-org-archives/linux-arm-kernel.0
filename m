From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 08:00:42 +0000
Subject: [PATCH 1/2] drivers: bus: add a new driver for omap-ocp2scp
In-Reply-To: <CAAe_U6K9sm-sDK80ySSHPGf5SYuwDkhW+4q8r2deXi7Tz3TxJw@mail.gmail.com>
References: <1342448023-14438-1-git-send-email-kishon@ti.com>
 <1342448023-14438-2-git-send-email-kishon@ti.com>
 <CAAe_U6K9sm-sDK80ySSHPGf5SYuwDkhW+4q8r2deXi7Tz3TxJw@mail.gmail.com>
Message-ID: <201207170800.43300.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012, ABRAHAM, KISHON VIJAY wrote:
> On Mon, Jul 16, 2012 at 7:43 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > Adds a new driver *omap-ocp2scp*. This driver takes the responsibility of
> > creating all the devices that is connected to OCP2SCP. In the case of OMAP4,
> > USB2PHY is connected to ocp2scp.
> >
> > This also includes device tree support for ocp2scp driver and
> > the documentation with device tree binding information is updated.
> >
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Now that we've found a place for the code to live, do we know which maintainer is
going to pick it up? If nobody else volunteers, we can take it through the
arm-soc tree.

	Arnd
