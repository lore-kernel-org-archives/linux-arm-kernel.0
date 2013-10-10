From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Oct 2013 14:18:17 -0500
Subject: [PATCH 0/2] ARM: dts: AM4372: Add more nodes
In-Reply-To: <1381432494-20498-1-git-send-email-lokeshvutla@ti.com>
References: <1381432494-20498-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <20131010191817.GJ21240@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 11, 2013 at 12:44:52AM +0530, Lokesh Vutla wrote:
> This patch series add nodes for l2-cache-controller, EDMA, mailbox,
> mmc, sham, and updates the properties for cpsw, i2c0, matrix-keypad. 
> 
> These patches are applied on top of Benoit's for_3.13/dts branch
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.13/dts
> 
> Testing:
> Tested EDMA, mmc, sham, aes, des, i2c0, cpsw, matric-keypad on AM4372 EPOS EVM
> with the addition of following two series:
> -> Tero's V8 of OMAP DT clock conversion
>   http://www.mail-archive.com/linux-omap at vger.kernel.org/msg96769.html
> -> Afzal's V5 of AM43x PRCM basic support
>   http://www.mail-archive.com/linux-omap at vger.kernel.org/msg96275.html

one extra piece of info:

all these patches are fresh out of Wakeup, tested on top of v3.12-rc3.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131010/eb11c696/attachment.sig>
