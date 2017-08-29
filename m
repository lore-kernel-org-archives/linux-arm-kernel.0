From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 29 Aug 2017 22:22:13 +0200
Subject: [PATCH 1/2] i2c: busses: make i2c_algorithm const
In-Reply-To: <1503072418-6887-2-git-send-email-bhumirks@gmail.com>
References: <1503072418-6887-1-git-send-email-bhumirks@gmail.com>
 <1503072418-6887-2-git-send-email-bhumirks@gmail.com>
Message-ID: <20170829202213.senab5jhzebku4de@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 09:36:57PM +0530, Bhumika Goyal wrote:
> Make these const as they are only stored in the algo field of
> i2c_adapter structure, which is const.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170829/58a3028d/attachment.sig>
