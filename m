From: artem.bityutskiy@intel.com (Bityutskiy, Artem)
Date: Mon, 13 Feb 2012 11:58:32 +0000
Subject: [PATCH] mtd/gpmi : add gpmi support for mx6q
In-Reply-To: <1328505606-27981-1-git-send-email-b32955@freescale.com>
References: <1328505606-27981-1-git-send-email-b32955@freescale.com>
Message-ID: <1329134454.22240.114.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-02-06 at 13:20 +0800, Huang Shijie wrote:
> add gpmi support to mx6q.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Please, let me know how I can compile-test this. This diver depends on
imx23 or imx28 and I cannot find a defconfig for these. When I select
MXS platform the compilation fails. Could you please describe some way
to generate a compilable configuration which would include this driver
as well, or send me the defconfig file.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120213/864fef04/attachment.sig>
-------------- next part --------------
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
