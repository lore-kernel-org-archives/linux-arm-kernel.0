From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 17 Aug 2012 14:29:44 +0300
Subject: [PATCH 1/1 v2] MTD: atmel nand: fix gpio missing request
In-Reply-To: <1342081868-5995-1-git-send-email-plagnioj@jcrosoft.com>
References: <1342071036-15905-1-git-send-email-plagnioj@jcrosoft.com>
 <1342081868-5995-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1345202984.27859.54.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-07-12 at 10:31 +0200, Jean-Christophe PLAGNIOL-VILLARD
wrote:
> without this the gpio will not be muxed as a gpio by the current custom pinmux
> or later by the pinctrl
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120817/7a694f35/attachment.sig>
