From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Jul 2011 16:47:24 +0300
Subject: [PATCH 04/15] ARM: pxa25x_udc: separate lubbock handling to
	lubbock-usb transceiver
In-Reply-To: <1309871321-11305-5-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
	<1309871321-11305-5-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20110705134723.GK2820@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 05, 2011 at 05:08:30PM +0400, Dmitry Eremin-Solenikov wrote:
> Move all handling of lubbock board to separate lubbock-usb transceiver,
> removing cruft from pxa25x_udc.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110705/519756fd/attachment.sig>
