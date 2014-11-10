From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Nov 2014 19:39:31 +0000
Subject: [PATCH] PM / Domains: Fix initial default state of the
 need_restore flag
In-Reply-To: <20141110183224.GA5626@dtor-ws>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org>
 <7hr3xerdw6.fsf@deeprootsystems.com>
 <20141107215751.GA4439@dtor-ws>
 <CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com>
 <20141110183224.GA5626@dtor-ws>
Message-ID: <20141110193931.GN3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 10:32:24AM -0800, Dmitry Torokhov wrote:

> - I do not see why sirincling platform specific code around i2c, spi,
>   etc bus code (which is not platform-specific) is OK, but a no-no for
>   the driver ocre.

sirincling?  In the case of I2C and SPI the buses don't define any sort
of power management or power domain so any management is going to be
device or system specific.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/a6b1c0cc/attachment.sig>
