From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 10 Dec 2017 13:23:00 -0200
Subject: [PATCH v1 6/6] ARM: dts: imx7s: add usb hsic phy domain
In-Reply-To: <20171205222707.11302-7-tyler@opensourcefoundries.com>
References: <20171205222707.11302-1-tyler@opensourcefoundries.com>
 <20171205222707.11302-7-tyler@opensourcefoundries.com>
Message-ID: <CAOMZO5ByDN2805b+PcnP+zJcs7OLmO_X7dwBH_eiTOgGH-cqoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 8:27 PM,  <tyler@opensourcefoundries.com> wrote:
> From: Tyler Baker <tyler@opensourcefoundries.com>
>
> The GPCv2 driver should control the MIPI, PCIe,
> and USB HSIC PHY regulators. Add the USB HSIC
> power domain to the GPC node.
>
> Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>

Looks good. I am assuming you tested USB HSIC operation on the mx7
compulab board, right?

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
