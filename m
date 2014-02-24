From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 24 Feb 2014 10:14:52 +0100
Subject: [PATCH] i2c: nomadik: Silence compiler warning
In-Reply-To: <1393173726-29479-1-git-send-email-ulf.hansson@linaro.org>
References: <1393173726-29479-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140224091452.GC2617@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 05:42:06PM +0100, Ulf Hansson wrote:
> Commit "i2c: nomadik: Fixup deployment of runtime PM" introduced a
> compiler warning for !CONFIG_PM. Let's fix it here.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Wolfram, currently one of the queued patches for i2c nomadik introduced a
> compiler warning. I decided to add a fixup patch on top of these instead of
> you dropping them and me resending new versions of the already applied patches.
> 
> If you think it's better to drop the queued patches and to resend new verions,
> please tell me.

I'll fold it into the causing patch since I haven't pushed out yet. I
was waiting for Linus response to the bus speed question.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140224/486d924f/attachment-0001.sig>
