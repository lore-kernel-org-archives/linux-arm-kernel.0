From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 17 Jun 2014 14:28:59 +0200
Subject: [PATCH v2] i2c: sun6-p2wi: fix call to snprintf
In-Reply-To: <1402655028-6214-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1402655028-6214-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140617122859.GB2683@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 12:23:48PM +0200, Boris BREZILLON wrote:
> Fixes possible issue in case pdev name contains formatting characters.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Reported-by: Kees Cook <keescook@google.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/5188624a/attachment.sig>
