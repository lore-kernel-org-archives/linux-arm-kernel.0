From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 12 Aug 2017 15:38:54 +0200
Subject: [PATCH v2 1/2] i2c: uniphier: add suspend / resume support
In-Reply-To: <1501480387-15692-1-git-send-email-yamada.masahiro@socionext.com>
References: <1501480387-15692-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170812133854.csmxs5d3x2xhkww2@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 02:53:06PM +0900, Masahiro Yamada wrote:
> When resuming, set up registers that have been lost in the sleep state.
> Also, add clock handling in the resume / suspend hooks.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170812/6c34f475/attachment.sig>
