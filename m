From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 Aug 2017 12:43:54 +0100
Subject: [PATCH RFC 2/2] spi: pxa2xx: Only claim CS GPIOs when the slave
 device is created
In-Reply-To: <5a691263ccf9d61134d6184861b37eaf37b13b77.1501760433.git.jan.kiszka@siemens.com>
References: <cover.1501760433.git.jan.kiszka@siemens.com>
 <5a691263ccf9d61134d6184861b37eaf37b13b77.1501760433.git.jan.kiszka@siemens.com>
Message-ID: <20170804114354.yxbaagwzmb5ri2hf@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 03, 2017 at 01:40:33PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Avoid hogging chip select GPIOs just because they are listed for the
> master. They might be mulitplexed and, if no slave device is attached,
> used for different purposes. Moreover, this strategy avoids having to
> allocate a cs_gpiods structure.

This doesn't apply against current code, please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170804/cd659330/attachment.sig>
