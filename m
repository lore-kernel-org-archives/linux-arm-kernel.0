From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 19 Jul 2016 06:23:27 +0200
Subject: [PATCH] i2c: efm32: fix a failure path in efm32_i2c_probe()
In-Reply-To: <1468625798-6767-1-git-send-email-khoroshilov@ispras.ru>
References: <1468625798-6767-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <20160719042327.GD1640@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2016 at 02:36:38AM +0300, Alexey Khoroshilov wrote:
> There is the only failure path in efm32_i2c_probe(),
> where clk_disable_unprepare() is missed.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160719/9b45af39/attachment.sig>
