From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 21 May 2014 10:29:17 +0200
Subject: [PATCH] i2c: cadence: fix Kconfig dependency
In-Reply-To: <4c4d2ba5-f5f6-4589-8a48-6a88d1c16098@VA3EHSMHS046.ehs.local>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <1396852656.682914397@f273.i.mail.ru>
 <20140407065657.GO29751@pengutronix.de>
 <1396854155.872298456@f287.i.mail.ru>
 <4c4d2ba5-f5f6-4589-8a48-6a88d1c16098@VA3EHSMHS046.ehs.local>
Message-ID: <20140521082917.GG2708@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'd propose the below fix. The relaxed IO helpers are currently
> available on ARM only and the clock notifier used, depends on
> COMMON_CLK. I2C-related dependencies should be okay due to the location in
> Kconfig of this option.

If somebody thinks an update is still needed, please resend against
latest i2c-next. Thanks.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/25330a54/attachment.sig>
