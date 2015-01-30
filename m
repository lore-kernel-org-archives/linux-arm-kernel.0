From: broonie@kernel.org (Mark Brown)
Date: Fri, 30 Jan 2015 13:30:33 +0100
Subject: [PATCH 7/7] spi: spi-fsl-dspi: Add support for TCFQ transfer mode
In-Reply-To: <1a28f3439386e1132ae0f3ab80666305@agner.ch>
References: <1422356608-15961-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356608-15961-2-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150128190342.GE21293@sirena.org.uk>
 <1422533049999.91114@toradex.com>
 <20150129121320.GI21293@sirena.org.uk>
 <1422536382672.21760@toradex.com>
 <1a28f3439386e1132ae0f3ab80666305@agner.ch>
Message-ID: <20150130123033.GC26617@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 07:10:31PM +0100, Stefan Agner wrote:

> It would be interesting to know what the authors original motivation
> implementing this feature was. Reading the email of the original
> patchset indicates that there are platforms where only TCF is supported:

> <quote>
> For adopting of different platform, either of them is a way of DSPI
> transfer data.
> </quote>

> However, I don't know which platform that would be. Also, it seems that
> Chao Fu's email is not valid anymore. 

It's not clear to me if the above means that this is due to hardware
differences or due to tuning for the platform.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150130/566d047e/attachment.sig>
