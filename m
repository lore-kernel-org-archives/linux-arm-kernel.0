From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Oct 2013 10:33:25 -0500
Subject: [PATCH] ARM: dts: omap3-beagle: Adapt USB OTG to generic PHY
 framework
In-Reply-To: <1381142810-14541-1-git-send-email-rogerq@ti.com>
References: <1381142810-14541-1-git-send-email-rogerq@ti.com>
Message-ID: <20131010153325.GH28375@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 01:46:50PM +0300, Roger Quadros wrote:
> The generic PHY framewrok expects different properties than the
> old USB PHY framework. Supply those properties.
> 
> Fixes USB OTG port on beagle after the Generic PHY framework was
> merged in greg/usb-next. [1]
> 
> [1] - https://lkml.org/lkml/2013/9/27/581
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131010/4f4eb2e6/attachment.sig>
