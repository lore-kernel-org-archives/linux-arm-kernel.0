From: horms@verge.net.au (Simon Horman)
Date: Fri, 23 Jun 2017 11:41:04 +0200
Subject: [PATCH] arm64: dts: r8a7795: Add DRIF support
In-Reply-To: <20170623091320.12664-1-ramesh.shanmugasundaram@bp.renesas.com>
References: <20170623091320.12664-1-ramesh.shanmugasundaram@bp.renesas.com>
Message-ID: <20170623094104.GA24191@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 10:13:20AM +0100, Ramesh Shanmugasundaram wrote:
> Adds the DRIF controller nodes for r8a7795.
> 
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
> Hi Simon,
> 
>    This patch is based on renesas-devel-20170622-v4.12-rc6 tag.
>    It is verified on both H3 ES1.1 and ES2.0 SoC revisions.
> 
>    The bindings[1] and the driver[2] were pushed into the media_tree.
> 
>    [1] https://git.linuxtv.org/media_tree.git/commit/?id=54a707ea011601f06cc5ef7fe6d0daac71ab0622
>    [2] https://git.linuxtv.org/media_tree.git/commit/?id=7625ee981af166ddb569e2e6c0006e2af471326f
> 

Thanks. Has this been tested not to cause regressions when
applied on top of renesas-devel-20170622-v4.12-rc6 (without the driver
changes) ?
