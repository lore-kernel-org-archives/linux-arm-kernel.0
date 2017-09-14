From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 14 Sep 2017 14:47:25 +0100
Subject: [v4 03/11] dt-bindings: soc/fsl: Update reserved memory binding
 for QBMan
In-Reply-To: <1503607075-28970-4-git-send-email-roy.pledge@nxp.com>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
 <1503607075-28970-4-git-send-email-roy.pledge@nxp.com>
Message-ID: <20170914134725.gltucphoi4lsqxpf@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 04:37:47PM -0400, Roy Pledge wrote:
> Updates the QMan and BMan device tree bindings for reserved memory
> nodes. This makes the reserved memory allocation compatible with
> the shared-dma-pool usage.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/bman.txt | 12 +++++-----
>  Documentation/devicetree/bindings/soc/fsl/qman.txt | 26 ++++++++++++++++------

This needs reviewed by the DT maintainers.

-- 
Catalin
