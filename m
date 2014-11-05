From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Wed, 05 Nov 2014 19:11:06 +0100
Subject: [PATCH] ASoC: samsung: Add MODULE_DEVICE_TABLE for Snow
In-Reply-To: <20141105170957.GE8509@sirena.org.uk>
References: <1415205892-5553-1-git-send-email-afaerber@suse.de>
 <20141105170957.GE8509@sirena.org.uk>
Message-ID: <545A683A.9010301@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 05.11.2014 um 18:09 schrieb Mark Brown:
> On Wed, Nov 05, 2014 at 05:44:52PM +0100, Andreas F?rber wrote:
>> This enables the snd_soc_snow module to be auto-loaded.
> 
> Applied, thanks.

Thanks. I notice you dropped my Fixes: line that SubmittingPatches asks
for. When do I need it and when should I leave it out? I thought it
tells GregKH more precisely which stable branches are affected for
backports than just a CC.

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/82ae6d9e/attachment.sig>
