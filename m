From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 19:52:34 +0000
Subject: [PATCH 3/7] spi: spi-fsl-dspi: Remove usage of devm_kzalloc
In-Reply-To: <1422356244-15629-4-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356244-15629-4-git-send-email-bhuvanchandra.dv@toradex.com>
Message-ID: <20150127195234.GP21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 04:27:20PM +0530, Bhuvanchandra DV wrote:
> devm_* API was supposed to be used only in probe function call.
> Memory is allocated at 'probe' and free automatically at 'remove'.

Applied, thanks.  Please don't dump entire backtraces into your commit
logs - they're far too big and not very helpful, they can obscure real
content in the message.  Explain in words what the problem is and if a
backtrace helps illustrate that edit it down to only relevant portions
rather than blindly including the entire thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/2fd40a42/attachment.sig>
