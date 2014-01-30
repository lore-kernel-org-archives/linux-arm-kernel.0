From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 30 Jan 2014 11:45:49 +0200
Subject: [PATCH v3 0/6] efuse driver for Tegra
In-Reply-To: <CAP=VYLpJT1T2RGuK73TXhSYn-K+ZrLx9FuhQe+hVXYGnfoOBcQ@mail.gmail.com>
References: <1390952176-30402-1-git-send-email-pdeschrijver@nvidia.com>
 <CAP=VYLpJT1T2RGuK73TXhSYn-K+ZrLx9FuhQe+hVXYGnfoOBcQ@mail.gmail.com>
Message-ID: <20140130094549.GD26588@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 04:00:27PM +0100, Paul Gortmaker wrote:
> On Tue, Jan 28, 2014 at 6:36 PM, Peter De Schrijver
> <pdeschrijver@nvidia.com> wrote:
> > This driver allows userspace to read the raw efuse data. Its userspace
> > interface is modelled after the sunxi_sid driver which provides similar
> > functionality for some Allwinner SoCs. It has been tested on
> > Tegra20 (ventana), Tegra30 (beaverboard) and Tegra114 (dalmore).
> >
> > Changes since v1:
> >
> > * Add documentation for sysfs interface
> > * Cleanup messages
> >
> > Changes since v2:
> >
> > * Incorporate early fuse code
> > * Remove module support
> > * Make driver always build when Tegra platform is selected
> 
> Given the above, you should be able to remove #include <linux/module.h>
> and MODULE_DEVICE_TABLE, etc.

Indeed. Thanks for noticing!

Cheers,

Peter.
