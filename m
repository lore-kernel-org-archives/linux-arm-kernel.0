From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 29 Aug 2017 22:35:40 +0200
Subject: [PATCH] i2c: nomadik: constify amba_id
In-Reply-To: <8f8b0a93aa6838c4a33e273758e159ab264dec4e.1503508729.git.arvind.yadav.cs@gmail.com>
References: <8f8b0a93aa6838c4a33e273758e159ab264dec4e.1503508729.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170829203540.qnds4j772c5v7npi@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 10:50:50PM +0530, Arvind Yadav wrote:
> amba_id are not supposed to change at runtime. All functions
> working with const amba_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170829/fa702e1d/attachment.sig>
