From: horms@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 11:17:47 +0200
Subject: [PATCH 00/11] arm64: dts: renesas: Use R-Car SDHI Gen[123]
 fallback compat strings
In-Reply-To: <20171017060959.16702-1-horms+renesas@verge.net.au>
References: <20171017060959.16702-1-horms+renesas@verge.net.au>
Message-ID: <20171020091747.iep6diy3ymp47qip@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 08:09:48AM +0200, Simon Horman wrote:
> Use recently posted R-Car SDHI Gen 1, 2 and 3 fallback compat strings
> in the DT of Renesas ARM and arm64 based SoCs.
> 
> Based on renesas-devel-20171016-v4.14-rc5
> 
> Has a binding documentation but no run-time dependency on
> "[PATCH v3 0/3] mmc: renesas_sdhi: add R-Car Gen[123] fallback
> compatibility strings"

I have marked these as deferred pending acceptance of the above dependency.
