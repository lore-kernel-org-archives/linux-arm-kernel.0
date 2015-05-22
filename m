From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 May 2015 13:40:10 +0100
Subject: [PATCH 11/13] sound/core: add IEC958 channel status helper
In-Reply-To: <E1Yr1y3-0006lC-JP@rmk-PC.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y3-0006lC-JP@rmk-PC.arm.linux.org.uk>
Message-ID: <20150522124010.GU21391@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 09, 2015 at 11:26:47AM +0100, Russell King wrote:
> Add a helper to create the IEC958 channel status from an ALSA
> snd_pcm_runtime structure, taking account of the sample rate and
> sample size.

This also looks good to me from an interface point of view:

Reviwed-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150522/0ea0bed5/attachment-0001.sig>
