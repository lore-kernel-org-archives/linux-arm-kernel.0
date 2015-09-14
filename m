From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Sep 2015 19:39:25 +0100
Subject: [PATCH] spi: mediatek: fix wrong error return value on probe
In-Reply-To: <1441320656-8666-1-git-send-email-javier@osg.samsung.com>
References: <1441320656-8666-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20150914183925.GG12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 12:50:56AM +0200, Javier Martinez Canillas wrote:
> Commit adcbcfea15d62 ("spi: mediatek: fix spi clock usage error")
> added a new sel_clk but introduced bugs in the error paths since
> the wrong struct clk pointers are passed to PTR_ERR().

This doesn't apply against current code, please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150914/3adc7575/attachment.sig>
