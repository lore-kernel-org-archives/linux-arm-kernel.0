From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 22 Mar 2017 10:16:03 -0700
Subject: [PATCH 10/15] ARM: dts: bcm: fix msi-controller name and unit
 address
In-Reply-To: <20170322020313.24338-10-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-10-robh@kernel.org>
Message-ID: <b0ac6b2e-b55f-7112-7d2a-2610d58a4232@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2017 07:03 PM, Rob Herring wrote:
> The unit address for the msi controller is not valid as there is no reg
> property, so remove it. Also, msi-controller is the preferred node name.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Jon Mason <jonmason@broadcom.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> ---
> Sub-arch maintainers, please apply to your trees unless arm-soc wants 
> to take the whole lot.

Applied, thanks Rob.
-- 
Florian
