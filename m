From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 9 Apr 2013 11:34:04 +0100
Subject: [PATCH V3 4/5] spi: s3c64xx: Added provision for dedicated cs pin
In-Reply-To: <CAKrE-KcMy1qzzg1JXqBOvAJTdQM3rLU6dHoQRnyryLz4p0rpaA@mail.gmail.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
 <1363157014-9615-5-git-send-email-ks.giri@samsung.com>
 <20130401125744.GG18636@opensource.wolfsonmicro.com>
 <CAKrE-Kd+YAFmteDdh3odtV+YU1=OjoMuQV9usF4NmUse+TXhTg@mail.gmail.com>
 <20130408101530.GC9243@opensource.wolfsonmicro.com>
 <CAKrE-KevVramLc1n_9kcfHVb=RKT_kexQ8iUP-5+BL3wxpMPbQ@mail.gmail.com>
 <20130408122056.GG9243@opensource.wolfsonmicro.com>
 <CAKrE-KcMy1qzzg1JXqBOvAJTdQM3rLU6dHoQRnyryLz4p0rpaA@mail.gmail.com>
Message-ID: <20130409103404.GO9243@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 07:19:05PM +0530, Girish KS wrote:

> I will move the populating cs_gpio logic to probe. But the enable_cs
> and disable_cs will have the
> check before calling the gpio_set_value api (because it takes cs-line
> as a parameter),

Yes, you'll still need to have a check.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130409/f3c91002/attachment.sig>
