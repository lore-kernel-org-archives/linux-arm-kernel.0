From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 25 Oct 2015 09:40:07 +0100
Subject: [PATCH-v5 RESEND 3/5] i2c: pxa: Add support for pxa910/988 & new
 configuration features
In-Reply-To: <55F65AF7.8090706@linaro.org>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-4-git-send-email-vaibhav.hiremath@linaro.org>
 <20150911190619.GB1516@katana> <55F65AF7.8090706@linaro.org>
Message-ID: <20151025084006.GD2159@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> And the i2c binding documentation, which says,
> for platforms using REGS_PXA2XX, they need to provide additional node
> "mrvl,pxa-i2c". Which is confusing :)

Yes, the description of the compatible entry is pretty bogus. Could you
fix that?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151025/756f7200/attachment.sig>
