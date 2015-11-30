From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 30 Nov 2015 14:51:41 +0100
Subject: [PATCH] i2c: mv64xxx: The n clockdiv factor is 0 based on sunxi
 SoCs
In-Reply-To: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
References: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20151130135140.GD1513@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2015 at 04:57:08PM +0200, Hans de Goede wrote:
> According to the datasheets to n factor for dividing the tclk is
> 2 to the power n on Allwinner?SoCs, not 2 to the power n + 1 as it is
> on other mv64xxx implementations.
> 
> I've contacted Allwinner about this and they have confirmed that the
> datasheet is correct.
> 
> This commit fixes the clk-divider calculations for Allwinner SoCs
> accordingly.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/ed500ee0/attachment-0001.sig>
