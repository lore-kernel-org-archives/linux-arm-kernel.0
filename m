From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 25 Jun 2013 23:44:47 +0200
Subject: [PATCH v3 1/4] i2c-mv64xxx: Set bus frequency to 100kHz if
 clock-frequency is not provided
In-Reply-To: <1371821529-13791-2-git-send-email-gregory.clement@free-electrons.com>
References: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
 <1371821529-13791-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130625214446.GA2951@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 03:32:06PM +0200, Gregory CLEMENT wrote:
> This commit adds checking whether clock-frequency property acquisition
> has succeeded. If not, the frequency is set to 100kHz by default.
> 
> The Device Tree binding documentation is updated accordingly.
> 
> Based on the intials patches from Zbigniew Bodek
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Zbigniew Bodek <zbb@semihalf.com>

Applied to for-next, thanks! Rest of the series is 3.12 material.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/707c68b3/attachment.sig>
