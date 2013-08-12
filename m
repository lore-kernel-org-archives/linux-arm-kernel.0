From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Aug 2013 11:38:21 +0100
Subject: [PATCH 1/5] ARM: pxa: ssp: remove unnecessary warning on
 kzalloc() failure
In-Reply-To: <1376296638-19804-2-git-send-email-zonque@gmail.com>
References: <1376296638-19804-1-git-send-email-zonque@gmail.com>
 <1376296638-19804-2-git-send-email-zonque@gmail.com>
Message-ID: <20130812103821.GN6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 10:37:14AM +0200, Daniel Mack wrote:
> The memory subsystem will already complain loudly enough in such cases.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130812/b025b3ca/attachment.sig>
