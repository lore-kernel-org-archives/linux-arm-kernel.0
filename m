From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 16 Feb 2014 18:02:01 +0100
Subject: [PATCH V2 11/17] i2c: nomadik: Convert to devm functions
In-Reply-To: <CAPDyKFrt6QJVSypP5iD_oVxRUvNhzxGcbZ703zR1K8gwJ5uCeQ@mail.gmail.com>
References: <1392300547-23365-1-git-send-email-ulf.hansson@linaro.org>
 <20140215150345.GD2579@katana>
 <CAPDyKFrt6QJVSypP5iD_oVxRUvNhzxGcbZ703zR1K8gwJ5uCeQ@mail.gmail.com>
Message-ID: <20140216170201.GA2831@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Would a way forward be to let you carry all the patches through your
> tree? I believe all but patch 17 can be safely merged. It is only this
> one that depends on the changes in the amba bus, so we can put this
> one on hold for a while.

I'd favour this. Will do this next week unless somebody objects.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140216/a5322d11/attachment.sig>
