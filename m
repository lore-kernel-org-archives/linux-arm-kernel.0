From: robh@kernel.org (Rob Herring)
Date: Mon, 11 Jun 2018 12:25:27 -0600
Subject: [v3, 03/10] dt-binding: ptp_qoriq: add DPAA FMan support
In-Reply-To: <20180607092050.46128-4-yangbo.lu@nxp.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
 <20180607092050.46128-4-yangbo.lu@nxp.com>
Message-ID: <20180611182527.GA13639@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2018 at 05:20:43PM +0800, Yangbo Lu wrote:
> This patch is to add bindings description for DPAA
> FMan 1588 timer, and also remove its description in
> fsl-fman dt-bindings document.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- None.
> Changes for v3:
> 	- None.
> ---
>  Documentation/devicetree/bindings/net/fsl-fman.txt |   25 +-------------------
>  .../devicetree/bindings/ptp/ptp-qoriq.txt          |   15 +++++++++--
>  2 files changed, 13 insertions(+), 27 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
