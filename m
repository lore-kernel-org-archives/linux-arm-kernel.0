From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 26 Jan 2018 18:53:45 +0100
Subject: [PATCH v4 1/3] i2c: mv64xxx: Remove useless test before
 clk_disable_unprepare
In-Reply-To: <20180116163540.1092-2-gregory.clement@free-electrons.com>
References: <20180116163540.1092-1-gregory.clement@free-electrons.com>
 <20180116163540.1092-2-gregory.clement@free-electrons.com>
Message-ID: <20180126175345.u2kobvakug223txs@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 05:35:38PM +0100, Gregory CLEMENT wrote:
> The 2 functions called from clk_disable_unprepare() already check that
> the clock pointer is valid: no need to test it before calling it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to for-next with a shortened commit msg, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180126/b95cc222/attachment.sig>
