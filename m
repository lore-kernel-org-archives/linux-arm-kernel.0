From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 21 May 2012 11:13:11 +0300
Subject: [PATCH] GPMI-NAND: Define ecc.strength
In-Reply-To: <1337571865-8016-1-git-send-email-marex@denx.de>
References: <1337571865-8016-1-git-send-email-marex@denx.de>
Message-ID: <1337587991.2483.65.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-05-21 at 05:44 +0200, Marek Vasut wrote:
> The ecc.strength wasn't set, resulting in the following crash:

How about ccing -stable? Can you find out which commit broke the driver?

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120521/b4df6bd7/attachment.sig>
