From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Jul 2013 20:28:55 +0300
Subject: [PATCH 1/6] usb: phy-nop: Use RESET Controller for managing the
 reset line
In-Reply-To: <1374137590-17865-2-git-send-email-rogerq@ti.com>
References: <1374137590-17865-1-git-send-email-rogerq@ti.com>
 <1374137590-17865-2-git-send-email-rogerq@ti.com>
Message-ID: <20130725172855.GJ25415@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 11:53:05AM +0300, Roger Quadros wrote:
> Till now we were modelling the RESET line as a voltage regulator and
> using the regulator framework to manage it.
> 
> [1] introduces a GPIO based reset controller driver. We use that
> to manage the PHY reset line, at least for DT boots. For legacy boots,
> will still need to use the regulator framework for reset lines.
> 
> [1] - http://thread.gmane.org/gmane.linux.drivers.devicetree/41348
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

that's not in mainline yet, right ? Is it guaranteed that it will hit
v3.12 merge window ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/fa2fd658/attachment.sig>
