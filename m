From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 13 Mar 2015 09:21:15 -0700
Subject: [PATCH v6 4/4] ARM: dts: enable PCIe support for Cygnus
In-Reply-To: <1426097169-20805-5-git-send-email-rjui@broadcom.com>
References: <1426097169-20805-1-git-send-email-rjui@broadcom.com>
 <1426097169-20805-5-git-send-email-rjui@broadcom.com>
Message-ID: <55030E7B.8080305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/15 11:06, Ray Jui wrote:
> Add PCIe device nodes in bcm-cygnus.dtsi but keep them disabled there.
> Only enable them for bcm958300k where PCIe interfaces are populated
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Applied to devicetree/next with Arnd's acked-by, thanks!
-- 
Florian
