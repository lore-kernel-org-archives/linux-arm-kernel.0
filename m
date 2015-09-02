From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 02 Sep 2015 13:44:47 -0700
Subject: [PATCH v4 2/5] ARM: NSP: add minimal Northstar Plus device tree
In-Reply-To: <1441064933-6723-1-git-send-email-jonmason@broadcom.com>
References: <1441064933-6723-1-git-send-email-jonmason@broadcom.com>
Message-ID: <55E75FBF.9060309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/08/15 16:48, Jon Mason wrote:
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

Applied this version to devicetree/next with Ray's tag, and consequently
dropped the previous version. Thanks!
-- 
Florian
