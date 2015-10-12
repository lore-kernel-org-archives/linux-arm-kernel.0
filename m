From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 13 Oct 2015 00:40:36 +0200
Subject: [PATCH 3/3] ARM: EXYNOS: delete unneeded of_node_put
In-Reply-To: <1444682596-3065-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1444682596-3065-1-git-send-email-Julia.Lawall@lip6.fr>
 <1444682596-3065-4-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <561C36E4.3050804@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Julia,

On 10/12/2015 10:43 PM, Julia Lawall wrote:
> Device node iterators perform an of_node_put on each iteration, so putting
> an of_node_put before going around to the next iteration results in a
> double put.
> 
> Problem found using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>

Krzysztof sent the same patch yesterday and was already applied:
https://lkml.org/lkml/2015/10/12/688

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
