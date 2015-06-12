From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Jun 2015 11:34:50 +0100
Subject: [PATCH 1/2] Revert "ASoC: atmel: compile pcm driver in
 snd-soc-atmel_ssc_dai"
In-Reply-To: <1434013569-24745-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1434013569-24745-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150612103450.GF1921@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 11:06:08AM +0200, Alexandre Belloni wrote:
> After discussing with the Kconfig maintainer, we found a better fiw
> allowing to keep each driver as modules.

Applied, but please use subject lines matching the style for the
subsystem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150612/72f9a25e/attachment.sig>
