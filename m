From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 May 2016 12:51:59 +0100
Subject: [RFC PATCH 1/7] ALSA: ac97: split out the generic ac97 registers
In-Reply-To: <1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20160503115159.GP6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 30, 2016 at 11:15:33PM +0200, Robert Jarzmik wrote:
> Split out from the ac97_codec.h the ac97 generic registers, which can be
> used by a codec, typically a generic ac97 codec, and by the ac97 bus, to
> scan an ac97 AC-Link.

I don't entirely see the value in this one but equally it does no harm.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160503/bbd13938/attachment.sig>
