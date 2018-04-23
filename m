From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 23 Apr 2018 13:56:57 +0200
Subject: [PATCH v6 01/11] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
In-Reply-To: <20180413151501.gvroqgbmwwyfy5pq@rob-hp-laptop>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-2-git-send-email-jollys@xilinx.com>
 <20180413151501.gvroqgbmwwyfy5pq@rob-hp-laptop>
Message-ID: <20180423115657.GB7951@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2018 at 10:15:01AM -0500, Rob Herring wrote:
> On Tue, Apr 10, 2018 at 12:38:37PM -0700, Jolly Shah wrote:
> > From: Rajan Vaja <rajanv@xilinx.com>
> > 
> > Add documentation to describe Xilinx ZynqMP firmware driver
> > bindings. Firmware driver provides an interface to firmware
> > APIs. Interface APIs can be used by any driver to communicate
> > to PMUFW (Platform Management Unit).
> > 
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> >  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 29 ++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> 
> Please add acks/reviewed-by's when posting new versions.

I'll just wait for the resend with those acks before considering to
merge these...

greg k-h
