From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 11 Oct 2012 14:15:21 +0300
Subject: [PATCH 1/1] mtd: st fsmc_nand: pass the ale and cmd resource
 via resource
In-Reply-To: <1349356456-13371-1-git-send-email-plagnioj@jcrosoft.com>
References: <1349356456-13371-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1349954121.12014.9.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-10-04 at 15:14 +0200, Jean-Christophe PLAGNIOL-VILLARD
wrote:
> Do not use the platform_data to pass resource and be smart in the drivers.
> Just pass it via resource
> 
> Switch to devm_request_and_ioremap at the sametime
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121011/85228016/attachment.sig>
