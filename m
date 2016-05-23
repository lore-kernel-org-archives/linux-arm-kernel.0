From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 May 2016 12:32:22 +0100
Subject: [PATCH] regulator: mt6397: Constify struct regulator_ops
In-Reply-To: <1463988616-18803-1-git-send-email-henryc.chen@mediatek.com>
References: <1463988616-18803-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <20160523113222.GT8206@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 03:30:16PM +0800, Henry Chen wrote:
> Consitify the structure of regulator operations.

Oh, actually the mode setting patch does apply but it depends on this
one (which was sent after...).  It would have been better to send a
patch series for the driver and separately a patch series for the core,
the driver changes are orthogonal to the core ones here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160523/1a6c87dd/attachment.sig>
