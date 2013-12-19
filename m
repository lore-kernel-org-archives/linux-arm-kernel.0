From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Dec 2013 14:09:22 +0800
Subject: [PATCH V2 1/7] PCI: imx6: Make reset-gpio optional
In-Reply-To: <20131218200645.GF15119@google.com>
References: <1386885004-10252-1-git-send-email-marex@denx.de>
 <20131218200645.GF15119@google.com>
Message-ID: <20131219060921.GX6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 01:06:45PM -0700, Bjorn Helgaas wrote:
> On Thu, Dec 12, 2013 at 10:49:58PM +0100, Marek Vasut wrote:
> > Some boards do not have a PCIe reset GPIO. To avoid probe
> > failure on these boards, make the reset GPIO optional as
> > well.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Frank Li <lznuaa@gmail.com>
> > Cc: Harro Haan <hrhaan@gmail.com>
> > Cc: Jingoo Han <jg1.han@samsung.com>
> > Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> > Cc: Pratyush Anand <pratyush.anand@st.com>
> > Cc: Richard Zhu <r65037@freescale.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Sean Cross <xobs@kosagi.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> > Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> > Cc: Tim Harvey <tharvey@gateworks.com>
> > Cc: Troy Kisky <troy.kisky@boundarydevices.com>
> > Cc: Yinghai Lu <yinghai@kernel.org>
> > ---
> >  .../devicetree/bindings/pci/designware-pcie.txt    |  2 ++
> >  drivers/pci/host/pci-imx6.c                        | 29 +++++++++++-----------
> >  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> Richard or Shawn, can you ack/nak these (patches 1-6)?  I'd like to dispose
> of them one way or the other.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
