From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 04 May 2012 12:41:50 +0300
Subject: [PATCH 1/2] mtd: gpmi: add device tree support to gpmi-nand
In-Reply-To: <1336101182-5200-1-git-send-email-b32955@freescale.com>
References: <1336101182-5200-1-git-send-email-b32955@freescale.com>
Message-ID: <1336124510.4275.7.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-05-04 at 11:13 +0800, Huang Shijie wrote:
> This patch just adds the DT support to gpmi-nand.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
> Please select the CONFIG_USE_OF before you do the compiler-test.
> thanks.

It should compile without CONFIG_USE_OF also just fine. Currently it
does not.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120504/07f4d455/attachment-0001.sig>
