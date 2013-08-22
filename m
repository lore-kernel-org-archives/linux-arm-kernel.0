From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 22 Aug 2013 18:17:16 +0200
Subject: [PATCH v6 1/4] i2c-mv64xxx: Add I2C Transaction Generator support
In-Reply-To: <1377181146-17341-1-git-send-email-gregory.clement@free-electrons.com>
References: <1377181146-17341-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130822161716.GA31704@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 04:19:05PM +0200, Gregory CLEMENT wrote:
> The I2C Transaction Generator offloads CPU from managing I2C
> transfer step by step.
> 
> This feature is currently only available on Armada XP, so usage of
> this mechanism is activated through device tree.
> 
> Based on the work of Piotr Ziecik and rewrote to use the new way of
> handling multiples i2c messages.
> 
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130822/d9157dad/attachment.sig>
