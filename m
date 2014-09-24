From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Sep 2014 10:07:36 +0100
Subject: [PATCH] misc: atmel-ssc: prepare clock only when request
In-Reply-To: <1411549019-12663-1-git-send-email-voice.shen@atmel.com>
References: <1411549019-12663-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20140924090736.GC16977@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 04:56:59PM +0800, Bo Shen wrote:
> Prepare SSC clock only when request SSC channel, the clock will be
> enabled when initialize the SSC.

You should send this to the drivers/misc maintainer.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140924/8ad9d41e/attachment.sig>
