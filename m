From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Jul 2011 14:01:20 +0300
Subject: [PATCH 2/7] enable usb1 phy power supply
In-Reply-To: <1311160106-4898-3-git-send-email-tony.lin@freescale.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-3-git-send-email-tony.lin@freescale.com>
Message-ID: <20110720110119.GK764@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 07:08:21PM +0800, Tony Lin wrote:
> configure usb1 phy power enable gpio and enable usb1 phy power
> 
> Signed-off-by: Tony Lin <tony.lin@freescale.com>

this one looks ok from a code stand point, no access to any MXC
documentation. FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110720/4c5cf526/attachment.sig>
