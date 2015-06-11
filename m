From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 11 Jun 2015 22:18:38 +0900
Subject: [PATCH 1/1] i2c: at91: fix code checker warnings
In-Reply-To: <7419376c5a4e60f1b23d36e66a102c7c40db1089.1434013494.git.cyrille.pitchen@atmel.com>
References: <cover.1434013494.git.cyrille.pitchen@atmel.com>
 <7419376c5a4e60f1b23d36e66a102c7c40db1089.1434013494.git.cyrille.pitchen@atmel.com>
Message-ID: <20150611131837.GB1510@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 11:16:32AM +0200, Cyrille Pitchen wrote:
> buf_len is a size_t, so unsigned but was tested with '<= 0'.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150611/88e0d7ec/attachment.sig>
