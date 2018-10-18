From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Oct 2018 13:25:32 -0500
Subject: [PATCH v4 1/4] dt-bindings: crypto: Mention clocks for mxs-dcp
In-Reply-To: <4536b5b5b101ab6a4197fb4891f775ddeb519847.1539779579.git.leonard.crestez@nxp.com>
References: <cover.1539779579.git.leonard.crestez@nxp.com>
 <4536b5b5b101ab6a4197fb4891f775ddeb519847.1539779579.git.leonard.crestez@nxp.com>
Message-ID: <20181018182532.GA28722@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Oct 2018 12:37:51 +0000, Leonard Crestez wrote:
> Explicit clock enabling is required on 6sll and 6ull so mention that
> standard clock bindings are used.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/crypto/fsl-dcp.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
