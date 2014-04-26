From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 26 Apr 2014 17:37:07 +0200
Subject: [PATCH] ARM: sun7i: Fix i2c4 base address
In-Reply-To: <1397848511-30160-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1397848511-30160-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140426153707.GC24905@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 09:15:11PM +0200, Maxime Ripard wrote:
> For some reason, the base address of the fifth I2C adapter in the A20 was
> incorrect. Change this to the actual base address.
> 
> Reported-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied to sunxi/fixes-for-3.15

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140426/6d65b836/attachment.sig>
