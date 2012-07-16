From: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 16 Jul 2012 21:49:57 +0100
Subject: [PATCH 2/2] mtd: gpmi: update the bitflip_threshold
In-Reply-To: <1341303873-23040-2-git-send-email-b32955@freescale.com>
References: <1341303873-23040-1-git-send-email-b32955@freescale.com>
 <1341303873-23040-2-git-send-email-b32955@freescale.com>
Message-ID: <1342471797.25411.31.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-07-03 at 16:24 +0800, Huang Shijie wrote:
> The origin code misses to update the bitflip_threshold when
> we have already get the right ecc_strength.
> 
> The patch fixes it.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com> 

Should we be pushing this for 3.5?

-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6171 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120716/56147f6f/attachment.bin>
