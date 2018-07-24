From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Jul 2018 17:20:18 -0600
Subject: [PATCH v6 3/4] arm64: dts: dwc3: description of incr burst type
In-Reply-To: <1532341959-3478-3-git-send-email-pengbo.mu@nxp.com>
References: <1532341959-3478-1-git-send-email-pengbo.mu@nxp.com>
 <1532341959-3478-3-git-send-email-pengbo.mu@nxp.com>
Message-ID: <20180724232018.GA16709@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 06:32:38PM +0800, Pengbo Mu wrote:
> Add description of 'snps,incr-burst-type-adjustment' to binding
> so that configuring devicetree.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
