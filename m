From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 20:53:49 +0100
Subject: [alsa-devel] [PATCH v2 12/12] ASoC: Fix use-after-free at card
 unregistration
In-Reply-To: <87injstckf.fsf@belgarion.home>
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
 <1497857229-12049-13-git-send-email-robert.jarzmik@free.fr>
 <s5hefug72iu.wl-tiwai@suse.de> <87injstckf.fsf@belgarion.home>
Message-ID: <20170628195349.pqeb3dceddxar75s@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 01:57:20PM +0200, Robert Jarzmik wrote:

> My serie shifted by one, so the very first of the serie is therefore missing,
> formerly "ALSA: ac97: split out the generic ac97 registers" in
> https://patchwork.kernel.org/patch/9398143/, and the shift triggered the
> inclusion of the last patch of my tree, ie. yours :)

Based on the missing first patch I was expecting the series to get
reposted?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170628/5132af47/attachment.sig>
