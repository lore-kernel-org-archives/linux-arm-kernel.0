From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:06:45 -0600
Subject: [PATCH 1/2] dt-bindings: nvmem: imx-ocotp: update the binding to
 reflect data cells
In-Reply-To: <1516865849-26191-1-git-send-email-aisheng.dong@nxp.com>
References: <1516865849-26191-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180205060546.qmifjvovungdomnr@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 03:37:28PM +0800, Dong Aisheng wrote:
> imx-ocotp is implemented based on nvmem which can have data cells
> as child node. Update the binding doc to reflect it to be more easily
> understood by users.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  .../devicetree/bindings/nvmem/imx-ocotp.txt        | 23 ++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
