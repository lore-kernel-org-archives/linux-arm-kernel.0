From: robh@kernel.org (Rob Herring)
Date: Thu, 21 Sep 2017 18:14:52 -0500
Subject: [v5 04/12] dt-bindings: soc/fsl: Update reserved memory binding
 for QBMan
In-Reply-To: <1505767187-4596-5-git-send-email-roy.pledge@nxp.com>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
 <1505767187-4596-5-git-send-email-roy.pledge@nxp.com>
Message-ID: <20170921231452.if6soolp6tzawbmx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 04:39:39PM -0400, Roy Pledge wrote:
> Updates the QMan and BMan device tree bindings for reserved memory
> nodes. This makes the reserved memory allocation compatible with
> the shared-dma-pool usage.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/bman.txt | 12 +++++-----
>  Documentation/devicetree/bindings/soc/fsl/qman.txt | 26 ++++++++++++++++------
>  2 files changed, 26 insertions(+), 12 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
