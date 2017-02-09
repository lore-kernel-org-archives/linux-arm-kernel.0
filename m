From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 9 Feb 2017 17:08:13 +0100
Subject: [PATCH] i2c: busses: constify i2c_algorithm structures
In-Reply-To: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
References: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170209160813.b77an7ywhx4gnxjc@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 11:36:17PM +0530, Bhumika Goyal wrote:
> Declare i2c_algorithm structures as const as they are only stored in the
> algo field of an i2c_adapter structure. This field is of type const, so
> i2c_algorithm structures having this property can be made const too.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to for-next with a shortened commit message, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170209/c5308865/attachment.sig>
