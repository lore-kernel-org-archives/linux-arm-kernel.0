From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 1 Mar 2016 19:19:36 +0100
Subject: [PATCH] i2c: brcmstb: allocate correct amount of memory for regmap
In-Reply-To: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
References: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20160301181936.GA1488@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 21, 2016 at 03:16:48PM +0100, Wolfram Sang wrote:
> We want the size of the struct, not of a pointer to it. To be future
> proof, just dereference the pointer to get the desired type.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-current with stable tag added, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160301/27b2c0c2/attachment-0001.sig>
