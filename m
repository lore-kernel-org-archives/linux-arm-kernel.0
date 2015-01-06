From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Jan 2015 17:45:11 +0000
Subject: [PATCH] sound: soc: atmel sam9g20_wm8731: remove useless include
In-Reply-To: <1420536080-29181-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1420536080-29181-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150106174511.GL2634@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 10:21:20AM +0100, Alexandre Belloni wrote:
> A mach/ header is included but never used. Simply remove it.

Applied, like I say please do use subject lines matching the style for
the subsystem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/22ee3f04/attachment.sig>
