From: robh@kernel.org (Rob Herring)
Date: Fri, 17 Aug 2018 09:09:48 -0600
Subject: [PATCH 7/7] Documentation: devicetree: Add Xilinx R5 rproc binding
In-Reply-To: <1534403190-28523-8-git-send-email-jliang@xilinx.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
 <1534403190-28523-8-git-send-email-jliang@xilinx.com>
Message-ID: <20180817150948.GA20845@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Thu, 16 Aug 2018 00:06:30 -0700, Wendy Liang wrote:
> Add device tree binding for Xilinx Cortex-r5 remoteproc.
> 
> Signed-off-by: Wendy Liang <jliang@xilinx.com>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
>  .../remoteproc/xlnx,zynqmp-r5-remoteproc.txt       | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
> 
