From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 May 2016 14:12:27 +0100
Subject: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
In-Reply-To: <s5h1t526ty2.wl-tiwai@suse.de>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
 <s5hk2j38tmf.wl-tiwai@suse.de> <87twi1hssl.fsf@belgarion.home>
 <s5hy47c7jvd.wl-tiwai@suse.de> <87mvnrhux4.fsf@belgarion.home>
 <s5hoa867e6v.wl-tiwai@suse.de> <87inyeidsr.fsf@belgarion.home>
 <s5h1t526ty2.wl-tiwai@suse.de>
Message-ID: <20160516131227.GL2953@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 02:58:13PM +0200, Takashi Iwai wrote:
> Robert Jarzmik wrote:

> > Even if I'd like to not have these in bus operations, the struct snd_ac97 had a
> > need for a 'caps', 'ext_id', ... fields for example. Yet these could be
> > contained in the ac97_codec_device structure and not exposed to bus operations.

> Do we have any example of such exceptions?  For AC97, we don't need to
> think of future extensions at all.

I can't think of any, even for some of the more fancy CODECs used in
embedded systems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160516/56fd982c/attachment.sig>
