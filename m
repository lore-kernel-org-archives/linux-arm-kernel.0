From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Nov 2014 18:44:38 +0000
Subject: [PATCH] ASoC: samsung: Add MODULE_DEVICE_TABLE for Snow
In-Reply-To: <545A683A.9010301@suse.de>
References: <1415205892-5553-1-git-send-email-afaerber@suse.de>
 <20141105170957.GE8509@sirena.org.uk> <545A683A.9010301@suse.de>
Message-ID: <20141105184438.GI8509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 07:11:06PM +0100, Andreas F?rber wrote:
> Am 05.11.2014 um 18:09 schrieb Mark Brown:
> > On Wed, Nov 05, 2014 at 05:44:52PM +0100, Andreas F?rber wrote:
> >> This enables the snd_soc_snow module to be auto-loaded.

> > Applied, thanks.

> Thanks. I notice you dropped my Fixes: line that SubmittingPatches asks
> for. When do I need it and when should I leave it out? I thought it
> tells GregKH more precisely which stable branches are affected for
> backports than just a CC.

It's not really adding anything if it's just identifying the patch that
created the file in the first place and what actually happened here is
that I applied it without the tag then later went back and decided to
add a stable Cc since it was probably worth that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/c70e7ce8/attachment-0001.sig>
