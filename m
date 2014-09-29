From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 29 Sep 2014 14:51:36 +0200
Subject: [PATCH v2] i2c: axxia: Add I2C driver for AXM55xx
In-Reply-To: <54293F2C.2090206@gmail.com>
References: <1411983159-4692-1-git-send-email-anders.berg@avagotech.com>
 <54292F74.2030209@gmail.com>
 <CAE0=X_0guSvMqZxHvdS39Zxx4G7qVvnddv96t72rp4FwpJLgfA@mail.gmail.com>
 <54293F2C.2090206@gmail.com>
Message-ID: <20140929125135.GA1327@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>Its looks good if we move the entire ISR above probe/remove
> >>functionalities...
> >>
> >Not sure what you mean here... The ISR _is_ above probe/remove.
> 
> I mean ISR should immediately above probe functionality. So that we can see
> devm_request_irq(..,isr_name,..) ISR directly with isr name..

Not so important to me, '*' in vim does that whereever the function is.

Still, thanks for the review!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/213aa9e7/attachment.sig>
