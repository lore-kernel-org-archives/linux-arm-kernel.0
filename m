From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 15 Jul 2012 22:11:21 +0100
Subject: [PATCH RESEND] gpio: of_get_named_gpio_flags() return
 -EPROBE_DEFER if GPIO not yet available
In-Reply-To: <CACRpkdYrZizqvZqsocLEGrkY5yPMuYFfmR3UUSFZgPDvEPa0eA@mail.gmail.com>
References: <1340836334-20427-1-git-send-email-stigge@antcom.de>
 <CACRpkdYrZizqvZqsocLEGrkY5yPMuYFfmR3UUSFZgPDvEPa0eA@mail.gmail.com>
Message-ID: <20120715211120.GH4041@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 14, 2012 at 09:57:08PM +0200, Linus Walleij wrote:

> If I understand correctly this relates closely to another patch from Mark Brown
> we discussed the other day (sorry for missing this patch, which arrived
> earlier, for a while).

> Mark/Grant can you look at this patch?

Not unless I have a copy of it, no...   I had thought a version of this
had been submitted already and was in a similar place to the one for
gpio_request().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120715/b356bb81/attachment.sig>
