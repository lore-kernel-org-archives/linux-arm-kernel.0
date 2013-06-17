From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 17 Jun 2013 09:12:51 +0200
Subject: [PATCH v3] i2c: vt8500: Add support for I2C bus on Wondermedia
 SoCs
In-Reply-To: <51BCE39D.4030505@prisktech.co.nz>
References: <1371246736-5460-1-git-send-email-linux@prisktech.co.nz>
 <20130615111817.GA2938@katana> <51BCE39D.4030505@prisktech.co.nz>
Message-ID: <20130617071250.GA2957@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 09:58:53AM +1200, Tony Prisk wrote:
> On 15/06/13 23:18, Wolfram Sang wrote:
> >On Sat, Jun 15, 2013 at 09:52:16AM +1200, Tony Prisk wrote:
> >>This patch adds support for the I2C bus controllers found on Wondermedia
> >>8xxx-series SoCs. Only master-mode is supported.
> >>
> >>Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> >>---
> >...
> >
> >>+/* REG_TR */
> >>+#define SCL_TIMEOUT(x)		(((x) & 0xFF) << 16)
> >I assume this should be << 8 since all regs are 16 bit wide.
> >
> >Fixed it locally and ready to apply. Please confirm or send a proper
> >fix. Rest looks fine.
> >
> >Thanks for the submission!
> >
> It should be << 8. Please apply your locally corrected version.

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130617/24bc5c45/attachment.sig>
