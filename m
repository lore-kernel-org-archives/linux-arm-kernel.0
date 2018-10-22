From: atull@kernel.org (Alan Tull)
Date: Mon, 22 Oct 2018 10:58:42 -0500
Subject: [PATCH 0/3] Add Bitstream configuration support for ZynqMP
In-Reply-To: <20181020084805.29103-1-nava.manne@xilinx.com>
References: <20181020084805.29103-1-nava.manne@xilinx.com>
Message-ID: <CANk1AXTUu=qiko9_sLrxrNxBmX7p0OXVxNN13p1uBirNh+Ymtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 3:49 AM Nava kishore Manne
<nava.manne@xilinx.com> wrote:

Hi Nava,

>
> This series of patches are created On top of the
> below repo.
> //git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> BRANCH: next/drivers.

IIUC this is dependent on some patches that aren't released yet.
Please make this explicit by specifying which patches this is
dependent on in each future submission of new versions.  It will help
so that I don't send these upstream prematurely and introduce build
breaks.  Of course, we can keep reviewing!

Thanks for submitting!
Alan

>
> Nava kishore Manne (3):
>   firmware: xilinx: Add fpga API's
>   dt-bindings: fpga: Add bindings for ZynqMP fpga driver
>   fpga manager: Adding FPGA Manager support for Xilinx zynqmp
>
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   |  17 ++
>  drivers/firmware/xilinx/zynqmp.c              |  46 +++++
>  drivers/fpga/Kconfig                          |   9 +
>  drivers/fpga/Makefile                         |   1 +
>  drivers/fpga/zynqmp-fpga.c                    | 159 ++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h          |   4 +
>  6 files changed, 236 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>  create mode 100644 drivers/fpga/zynqmp-fpga.c
>
> --
> 2.18.0
>
