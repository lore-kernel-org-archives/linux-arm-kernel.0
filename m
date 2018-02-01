From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 1 Feb 2018 10:27:30 +0000
Subject: [PATCH v3 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
In-Reply-To: <CY1PR0201MB076454E915A6E6947A39F04BB8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-2-git-send-email-jollys@xilinx.com>
 <20180131180354.mqf4gvvprdtycbn5@lakrids.cambridge.arm.com>
 <CY1PR0201MB076454E915A6E6947A39F04BB8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
Message-ID: <20180201102730.33q4xrjw3vhrgk4i@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 01:04:45AM +0000, Jolly Shah wrote:
> > > +Xilinx Zynq MPSoC Firmware Device Tree Bindings
> > > +
> > > +The zynqmp-firmware node describes the interface to platform firmware.
> > 
> > Is there any documentation for this that can be referred to?
> >
> 
> Will add more information about supported APIs in next version patch.
> Below document describes interface APIs though it is not latest.   
> https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf

Thanks for the link.

It might be better for the compatible string to be "xlnx,zynqmp-eemi",
to make it clear which firmware interfaces are being described, assuming
that this being is only intended to cover EEMI.

Thanks,
Mark.
