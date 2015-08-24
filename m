From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 24 Aug 2015 09:42:56 +0200
Subject: [PATCH v3 1/2] devicetree: bindings: rtc: add bindings for
 xilinx zynqmp rtc
In-Reply-To: <1439978002-12157-1-git-send-email-suneel.garapati@xilinx.com>
References: <1439978002-12157-1-git-send-email-suneel.garapati@xilinx.com>
Message-ID: <20150824074256.GE13155@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/08/2015 at 15:23:21 +0530, Suneel Garapati wrote :
> adds file for description on device node bindings for RTC
> found on Xilinx Zynq Ultrascale+ MPSoC.
> 
> Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
> ---
> Changes v3 
> - none 
> Changes v2 
> - add examples for interrupt-names 
> - change alm to alarm 
> ---
>  Documentation/devicetree/bindings/rtc/xlnx-rtc.txt | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
