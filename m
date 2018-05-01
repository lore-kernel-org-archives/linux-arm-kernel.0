From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 07:54:42 -0500
Subject: [PATCHv2 1/3] Documentation: dt: socfpga: Add Stratix10 ECC
 Manager binding
In-Reply-To: <1524854238-19394-2-git-send-email-thor.thayer@linux.intel.com>
References: <1524854238-19394-1-git-send-email-thor.thayer@linux.intel.com>
 <1524854238-19394-2-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <20180501125442.GA12012@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 01:37:16PM -0500, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add the device tree bindings needed to support the Stratix10
> ECC Manager and SDRAM ECC.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2  Remove unused System Manager syscon.
>     Remove unused SDRAM ECC register defines.
>     Remove unused address, size and range from bindings.
> ---
>  .../bindings/arm/altera/socfpga-eccmgr.txt         | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

This should move to bindings/edac/. Can you do that as a follow-up 
patch?

Reviewed-by: Rob Herring <robh@kernel.org>
