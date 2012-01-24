From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Jan 2012 11:38:32 +0200
Subject: [PATCH 3/3] S3C2443: add power domain for usb phy
In-Reply-To: <201201082159.02368.heiko@sntech.de>
References: <201201082156.44142.heiko@sntech.de>
 <201201082159.02368.heiko@sntech.de>
Message-ID: <20120124093831.GT27414@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 08, 2012 at 09:59:02PM +0100, Heiko St?bner wrote:
> The phy-power-handling is common to S3C2443/2416/2450, so introduce a
> s3c2443-pm-common.c to handle this for all of them.
> 
> This makes it possible to remove the raw write to the PWRCFG-register
> from the s3c-hsudc driver.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

I believe this doesn't really depend on previous patches (??) In that
case, it can be carried with s3c's tree:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120124/17509f4c/attachment.sig>
