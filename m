From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 19 Feb 2014 17:05:04 +0100
Subject: [PATCH V4 16/17] i2c: nomadik: Remove busy check for transfers
 at suspend late
In-Reply-To: <1392812867-19212-1-git-send-email-ulf.hansson@linaro.org>
References: <1392812867-19212-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140219160504.GC13973@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 01:27:47PM +0100, Ulf Hansson wrote:
> We should never be busy performing transfers at suspend late, thus
> there are no reason to check for it.
> 
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Okay applied up to patch 16 in a local branch. Waiting for LinusW to
comment on the 100kHz vs 400kHz issue before pushing out. If patch 17
can be applied now, please say so. If not, please resend when
dependencies are upstream.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/3da5c837/attachment.sig>
