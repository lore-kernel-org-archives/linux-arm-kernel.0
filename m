From: balbi@ti.com (Felipe Balbi)
Date: Tue, 20 Dec 2011 13:27:17 +0200
Subject: [PATCH 8/8] s3c-hsudc: remove the_controller global
In-Reply-To: <201112191943.35591.heiko@sntech.de>
References: <201112191938.22254.heiko@sntech.de>
 <201112191943.35591.heiko@sntech.de>
Message-ID: <20111220112716.GH31842@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 19, 2011 at 07:43:35PM +0100, Heiko St?bner wrote:
> Instead use container_of to retrieve the s3c_hsudc from the
> struct usb_gadget pointer.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

aha, it's here. So I replied too fast. Sorry about that and thanks for
doing this.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111220/9ec3e5da/attachment.sig>
