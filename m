From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Sep 2015 19:17:51 +0100
Subject: [RESEND PATCH 1/1] ASoC: dwc: correct irq clear method
In-Reply-To: <006301d0fac4$94eb5890$bec209b0$@tangramtek.com>
References: <006301d0fac4$94eb5890$bec209b0$@tangramtek.com>
Message-ID: <20150930181751.GT15635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 10:39:00PM +0800, yitian wrote:
> from Designware I2S datasheet, irq is cleared by reading from
> TOR/ROR registers, rather than by writing into them.

This doesn't apply against current code, please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/779b74a0/attachment-0001.sig>
