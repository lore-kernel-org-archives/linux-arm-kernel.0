From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Jan 2012 11:37:30 +0200
Subject: [PATCH 2/3] s3c-hsudc: add basic runtime_pm calls
In-Reply-To: <201201082158.28694.heiko@sntech.de>
References: <201201082156.44142.heiko@sntech.de>
 <201201082158.28694.heiko@sntech.de>
Message-ID: <20120124093729.GS27414@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 09:58:28PM +0100, Heiko St?bner wrote:
> This will enable the system to check for activity of the usb gadget
> and also in a later patch to control the usbphy power-domain.
> When handling the power domain there, it will be possible to remove
> another reference to architecture code.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied, thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120124/675c6db5/attachment.sig>
