From: tj@kernel.org (Tejun Heo)
Date: Tue, 15 Apr 2014 12:03:17 -0400
Subject: [PATCH 1/2] ahci: imx: use macros to define registers and bits
In-Reply-To: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140415160317.GM1863@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 10:41:42AM +0800, Shawn Guo wrote:
> Comparing to enums, macros are more conventional to be used for
> registers and bits definition.  Let's switch to macros.
> 
> While at it, the names of the registers and bit-fields are updated to
> have proper namespace prefix and match the hardware reference manual.
> 
> No functional change is involved.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

Please don't switch to defines.  A lot of libata constants use enums
and they tend to have more advantages anyway.

Thanks.

-- 
tejun
