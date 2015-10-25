From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 25 Oct 2015 09:25:02 +0100
Subject: [PATCH-v5 RESEND 3/5] i2c: pxa: Add support for pxa910/988 & new
 configuration features
In-Reply-To: <1440395978-9065-4-git-send-email-vaibhav.hiremath@linaro.org>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-4-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20151025082502.GB2159@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 11:29:36AM +0530, Vaibhav Hiremath wrote:
> TWSI_ILCR & TWSI_IWCR registers are used to adjust clock rate
> of standard & fast mode in pxa910/988; so this patch adds these two new
> entries to "struct pxa_reg_layout" and "struct pxa_i2c".
> 
> As discussed in the previous patch-series, the idea here is to add standard
> DT properties for ilcr and iwcr configuration fields.
> In case of Master ilcr is used for low/high time and in case of slave mode
> of operation iwcr is used for setup/hold time.
> 
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> Signed-off-by: Yi Zhang <yizhang@marvell.com>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Fixed this checkpatch warning:

CHECK: Please don't use multiple blank lines
#82: FILE: drivers/i2c/busses/i2c-pxa.c:157:
+
+

and applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151025/384c675e/attachment.sig>
