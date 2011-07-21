From: balbi@ti.com (Felipe Balbi)
Date: Thu, 21 Jul 2011 16:59:39 +0300
Subject: [PATCHV3 2/4] OMAP: I2C: Remove the reset in the init path
In-Reply-To: <1311256381-25548-3-git-send-email-shubhrajyoti@ti.com>
References: <1311256381-25548-1-git-send-email-shubhrajyoti@ti.com>
	<1311256381-25548-3-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20110721135938.GC30943@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 21, 2011 at 07:22:59PM +0530, Shubhrajyoti D wrote:
> The reset in the driver at init is not needed
> anymore as the hwmod framework takes care of
> reseting it.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

this is still doing two things:

a. remove the reset from init path
b. add and use ->device_reset() when needed.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110721/98c6501c/attachment.sig>
