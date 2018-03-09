From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 9 Mar 2018 11:51:49 +0800
Subject: [PATCH v4 1/2] Doc: dt: binding: imx: update pinctrl doc for
 imx6sll
In-Reply-To: <1520503083-22819-1-git-send-email-ping.bai@nxp.com>
References: <1520503083-22819-1-git-send-email-ping.bai@nxp.com>
Message-ID: <20180309035148.GJ3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 05:58:02PM +0800, Bai Ping wrote:
> Add pinctrl binding doc update for imx6sll.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
>  changes v2-v3:
>  - add generic config binding
> 
>  change v3->v4:
>  - add SION bit define
>  - fix typo
>  - move the pin header file to dts patch.
> ---
>  .../bindings/pinctrl/fsl,imx6sll-pinctrl.txt       | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt

Suggest "dt-bindings: add pinctrl bindings doc for imx6sll" as subject.

Shawn
