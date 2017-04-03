From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Apr 2017 10:42:29 -0500
Subject: [RFC PATCH 4/5] dt-bindings: soc/fsl: Update reserved memory
 binding for QBMan
In-Reply-To: <1490822037-6752-5-git-send-email-roy.pledge@nxp.com>
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
 <1490822037-6752-5-git-send-email-roy.pledge@nxp.com>
Message-ID: <20170403154229.mf63zeiwv5naxyrr@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 05:13:56PM -0400, Roy Pledge wrote:
> Updates the QMan and BMan device tree bindings for reserved memory
> nodes. This makes the reserved memory allocation compatiable with

s/compatiable/compatible/

> the shared-dma-pool usage.

This change is not backwards compatible. Please state that and explain 
why that is okay. If PPC needs to not change, then the old strings and 
properties should remain, but deprecated.

> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/bman.txt | 10 +++++-----
>  Documentation/devicetree/bindings/soc/fsl/qman.txt | 16 +++++++++-------
>  2 files changed, 14 insertions(+), 12 deletions(-)
