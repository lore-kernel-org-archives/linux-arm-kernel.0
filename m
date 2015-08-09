From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 9 Aug 2015 09:43:12 +0200
Subject: [PATCH] i2c: cadence: set THIS_MODULE to the owner of the adapter
In-Reply-To: <1437462876-13755-1-git-send-email-yamada.masahiro@socionext.com>
References: <1437462876-13755-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150809074312.GD1526@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 04:14:36PM +0900, Masahiro Yamada wrote:
> The owner of the adapter is missing, while this driver is tristate.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150809/82a0004f/attachment.sig>
