From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 22 Apr 2015 09:42:54 +0200
Subject: [PATCH] i2c: rk3x: report number of messages transmitted
In-Reply-To: <20150420221447.GA2005@dtor-ws>
References: <20150420221447.GA2005@dtor-ws>
Message-ID: <20150422074254.GB1511@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 03:14:47PM -0700, Dmitry Torokhov wrote:
> master_xfer() method should return number of i2c messages transferred,
> but on Rockchip we were usually returning just 1, which caused trouble
> with users that actually check number of transferred messages vs.
> checking for negative error codes.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150422/7b2fe6a9/attachment.sig>
