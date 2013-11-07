From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 7 Nov 2013 21:13:32 +0100
Subject: [RESEND PATCH 2/4] i2c: i2c-bcm-kona: Add support for high-speed
 mode
In-Reply-To: <CAAYSxhrrkSvOJpYPz7txVsot1you3fFzkXJ6fqaS4OgRM0Z2gA@mail.gmail.com>
References: <1381960909-1735-1-git-send-email-tim.kryger@linaro.org>
 <1381960909-1735-3-git-send-email-tim.kryger@linaro.org>
 <20131101130835.GC6734@katana>
 <CAAYSxhrrkSvOJpYPz7txVsot1you3fFzkXJ6fqaS4OgRM0Z2gA@mail.gmail.com>
Message-ID: <20131107201332.GA7119@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> While the bus speed property is really a configuration parameter (and
> not a true description of of the hardware) it seems improper to put
> driver specific details into the binding document.

OK. Then please change the error message for unsupported bus speeds to
contain the supported ones. I don't think it is good practice to force
users to look into the sourcecode to find this information.

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131107/276be82b/attachment.sig>
