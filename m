From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 31 Aug 2017 14:32:55 -0300
Subject: [PATCH 1/3] PCI: designware: only register MSI controller when
 MSI irq line is valid
In-Reply-To: <20170831165817.GD18250@bhelgaas-glaptop.roam.corp.google.com>
References: <20170828142307.30061-1-l.stach@pengutronix.de>
 <20170828142307.30061-2-l.stach@pengutronix.de>
 <20170831165817.GD18250@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <CAOMZO5DuFiCTMCdw8SNY9QBXFDVFbPa9wagwiJvsZOwYeBTeNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Thu, Aug 31, 2017 at 1:58 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> Incidental observations not strictly related to this series:
>
>   - It looks like exynos_add_pcie_port() incorrectly assumes
>     platform_get_irq() returns zero on failure (twice).

I will send a series cleaning up the error handling in
platform_get_irq() for the various PCI drivers.
