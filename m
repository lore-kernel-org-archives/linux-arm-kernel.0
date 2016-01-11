From: broonie@kernel.org (Mark Brown)
Date: Mon, 11 Jan 2016 16:13:33 +0000
Subject: [PATCH v2] spi: atmel: improve internal vs gpio chip-select choice
In-Reply-To: <1452528102-26458-1-git-send-email-mans@mansr.com>
References: <1452528102-26458-1-git-send-email-mans@mansr.com>
Message-ID: <20160111161333.GK6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 04:01:42PM +0000, Mans Rullgard wrote:
> The driver currently chooses between internal chip-select or gpio
> based on the existence of the cs-gpios DT property which fails on
> non-DT systems and also enforces the same choice for all devices.

Normally you shouldn't send incremental patches against patches that
have already been applied.  However in this case I'm going to drop your
original patch anyway due to the issue that was found so it's OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160111/0ffbe160/attachment.sig>
