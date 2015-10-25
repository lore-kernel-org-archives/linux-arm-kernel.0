From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 25 Oct 2015 09:21:53 +0100
Subject: [PATCH-v5 RESEND 2/5] i2c: pxa: enable/disable i2c module across
 msg xfer
In-Reply-To: <55F655FC.8070308@linaro.org>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150911185312.GA1516@katana> <55F655FC.8070308@linaro.org>
Message-ID: <20151025082152.GA2159@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >>Enable i2c module/unit before transmission and disable when it
> >>finishes.
> 
> >Can't you use Runtime PM for that?
> >
> 
> I haven't tried it though, I can give a try and check.

It should work. Other I2C drivers are doing exactly that.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151025/dad827ee/attachment-0001.sig>
