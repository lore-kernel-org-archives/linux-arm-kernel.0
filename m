From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 12 Aug 2017 15:38:57 +0200
Subject: [PATCH v2 2/2] i2c: uniphier-f: add suspend / resume support
In-Reply-To: <1501480387-15692-2-git-send-email-yamada.masahiro@socionext.com>
References: <1501480387-15692-1-git-send-email-yamada.masahiro@socionext.com>
 <1501480387-15692-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170812133857.36gzdcbjf6a7ybht@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 02:53:07PM +0900, Masahiro Yamada wrote:
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170812/40c30ef7/attachment.sig>
