From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 08:41:03 -0500
Subject: [PATCH] dt-bindings: arm: consistently name r8a77965 as M3-N
In-Reply-To: <20180424055442.19710-1-horms+renesas@verge.net.au>
References: <20180424055442.19710-1-horms+renesas@verge.net.au>
Message-ID: <20180501134103.GA29214@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 07:54:42AM +0200, Simon Horman wrote:
> There is an inconsistency between the use of M3N and M3-N.
> This patch resolves this by consistently using the latter.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on renesas-devel-20180423-v4.17-rc2
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
