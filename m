From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Aug 2016 16:35:51 +0100
Subject: [PATCH v7 14/14] Documentation: remove the constraint on the
 distances of node pairs
In-Reply-To: <1472024693-12912-15-git-send-email-thunder.leizhen@huawei.com>
References: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
 <1472024693-12912-15-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20160826153550.GI30302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 03:44:53PM +0800, Zhen Lei wrote:
> Update documentation. This limit is unneccessary.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/numa.txt | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> index 21b3505..c0ea4a7 100644
> --- a/Documentation/devicetree/bindings/numa.txt
> +++ b/Documentation/devicetree/bindings/numa.txt
> @@ -48,7 +48,6 @@ distance (memory latency) between all numa nodes.
> 
>    Note:
>  	1. Each entry represents distance from first node to second node.
> -	The distances are equal in either direction.

Hmm, so what happens now if firmware provides a description where both
distances (in either direction) are supplied, but are different?

Will
