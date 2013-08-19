From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 19 Aug 2013 20:56:33 +0200
Subject: [PATCH RESEND] i2c: move of helpers into the core
In-Reply-To: <5212624D.5090708@samsung.com>
References: <1376918361-7014-1-git-send-email-wsa@the-dreams.de>
 <1376935183-11218-1-git-send-email-wsa@the-dreams.de>
 <5212624D.5090708@samsung.com>
Message-ID: <20130819185633.GA12011@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> However this patch fails to apply onto either v3.11-rc4 or v3.11-rc6:

Argh, did not drop the MPC patch before rebasing :( So either pick the
patch "i2c: powermac: fix return path on error" before, pull the branch
[1], or force me to resend ;)

Thanks!

[1] git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/core-with-of
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130819/8253fb4f/attachment.sig>
