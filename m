From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Fri, 23 Sep 2011 18:23:00 -0400
Subject: [PATCHv9 00/18] omap PRCM chain handler
In-Reply-To: Your message of "Fri, 23 Sep 2011 15:46:08 +0300."
	<1316781986-30642-1-git-send-email-t-kristo@ti.com>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
Message-ID: <35343.1316816580@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Sep 2011 15:46:08 +0300, Tero Kristo said:
> Following set contains the version 9 of this work. This patch set contains
> a number of patches tagged as 'TEMP', they are only meant for testing
> purposes and to provide proof of concept. Most of the 'TEMP' patches are
> related to UART runtime handling and they will be replaced by work done
> by Govindraj Raja.

What do we do with these TEMP patches if the UART patches don't make the same
merge window, or have other issues?  I'm always leery of "will be replaced"
code, because I've seen too many times when it *didn't* get replaced.

(I really don't care what the 'Plan B' is, as long as we have one...)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110923/48e9cd85/attachment.sig>
