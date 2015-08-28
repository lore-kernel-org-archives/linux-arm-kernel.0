From: fainelli@broadcom.com (Florian Fainelli)
Date: Thu, 27 Aug 2015 17:44:47 -0700
Subject: [PATCH v2 2/5] ARM: NSP: add minimal Northstar Plus device tree
In-Reply-To: <1440628530-6137-3-git-send-email-jonmason@broadcom.com>
References: <1440628530-6137-1-git-send-email-jonmason@broadcom.com>
 <1440628530-6137-3-git-send-email-jonmason@broadcom.com>
Message-ID: <55DFAEFF.9030305@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/15 15:35, Jon Mason wrote:
> Add a very minimalistic set of Northstar Plus Device Tree files which
> describes the SoC and the BCM958625 implementation.  The perpherials
> described are:
> 
> ARM Cortex A9 CPU
> 2 8250 UARTs
> ARM GIC
> PL310 L2 Cache
> ARM A9 Global timer
> 
> Signed-off-by: Kapil Hali <kapilh@broadcom.com>
> Signed-off-by: Jon Mason <jonmason@broadcom.com>

Applied to devicetree/next, thanks!
-- 
Florian
