From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Sep 2013 10:48:08 +0100
Subject: [PATCH] ASoC: atmel: disable error interrupt
In-Reply-To: <1378279666-19873-1-git-send-email-voice.shen@atmel.com>
References: <1378279666-19873-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20130904094808.GP3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 04, 2013 at 03:27:46PM +0800, Bo Shen wrote:
> As once the error interrupt is triggered, it can not be cleared.
> So, disable it.
> 
> No side effect found while testing on sama5d3xek and at91sam9x5ek
> boards.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130904/b25162c5/attachment.sig>
