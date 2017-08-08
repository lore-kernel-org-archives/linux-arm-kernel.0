From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 08 Aug 2017 14:37:03 +0200
Subject: [PATCH 5/6] [media] exynos4-is: constify video_subdev structures
In-Reply-To: <1502189912-28794-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1502189912-28794-1-git-send-email-Julia.Lawall@lip6.fr>
 <1502189912-28794-6-git-send-email-Julia.Lawall@lip6.fr>
 <CGME20170808123709epcas2p229a31cfa19e3a5bf3986e547162e2613@epcas2p2.samsung.com>
Message-ID: <5c673a72-98f6-1501-845e-7d83fabfa659@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2017 12:58 PM, Julia Lawall wrote:
> The v4l2_subdev_ops structures are only passed as the second
> argument of v4l2_subdev_init, which is const, so the
> v4l2_subdev_ops structures can be const as well.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall<Julia.Lawall@lip6.fr>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
