From: horms@verge.net.au (Simon Horman)
Date: Thu, 14 Jun 2018 09:23:39 +0200
Subject: [PATCH v3 1/2] arm64: dts: renesas: r8a77980: add
 FCPVD/VSPD/DU/LVDS support
In-Reply-To: <1611fe94-07dd-fc8b-e94f-143e1ed26a17@cogentembedded.com>
References: <95d0db34-713d-8206-00c2-ee9a42aab823@cogentembedded.com>
 <1611fe94-07dd-fc8b-e94f-143e1ed26a17@cogentembedded.com>
Message-ID: <20180614072338.ti7pejilvbfqhegn@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 11:11:27PM +0300, Sergei Shtylyov wrote:
> Describe the interconnected FCPVD0, VSPD0, DU, and LVDS0 devices in the
> R8A77980 device tree...
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ---
> Changes in version 3:
> - merged in the VSPD/DU/LVDS patches, renamed the patch, and updated the patch
>   description accordingly;
> - fixed the VSPD0's "reg" property.

Thanks Sergei, applied.
