From: weigelt@melag.de (Enrico Weigelt, metux IT consult)
Date: Thu, 28 May 2015 18:52:52 +0200
Subject: Device Tree Blob (DTB) licence
In-Reply-To: <20150528133429.GD2067@n2100.arm.linux.org.uk>
References: <1430820315.19516.26.camel@opteya.com>
 <CAL_Jsq+T5c7qornpRVCduEjUSCeM+0xqbtVYovtH76y=4BqhLQ@mail.gmail.com>
 <1432289148.5304.58.camel@opteya.com> <1432322832.5304.63.camel@opteya.com>
 <CAOS_Y6Q37ps+VEnzUZ_uwX++qrRm9Hgx45Q_pmiZSLSNjmKwZg@mail.gmail.com>
 <55670AD4.8020705@melag.de> <20150528133429.GD2067@n2100.arm.linux.org.uk>
Message-ID: <556747E4.6070403@melag.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.05.2015 um 15:34 schrieb Russell King - ARM Linux:

>> What's the big deal with having DTS/DTB under GPL ?
>
> It's really quite simple.  Other open source projects won't touch
> _our_ DTB with a barge pole through fear of GPL contamination.

Which other foss projects do you have in mind ?
And why should they fear "poisoning" ?

The DTB is an entirely separate file. Just like various firmware
blobs, startup scripts, etc, etc. Just shipping that file (be it in
some source tarball or in the flash of some device) doesn't make
everything else an derived work.

Of course, the viral effect of the GPL could catch in if somebody
directly compiles-in the dtb into something else (so it cant be
easily separated / replaced) - but why should anybody wanna do that ?
Sounds to me like defeating the whole purpose of DTB.

> So what we'll end up with is other projects creating their own DTB
> descriptions for the same hardware, with different properties (which
> they'll do in an effort to ensure that it isn't a "derived work" of
> the GPL version) and the whole thing turning into a right mess - and
> a poor experience for users because they then end up with OS specific
> DT files.

Anybody is free do to everything on his own. Same as everybody is free
to write his own kernel, etc.

But I dont see a practical usecase where the GPL's viral effect could
catch in here in the first place.

> Alternatively, as Rob points out, people will just go the ACPI route
> to avoid the GPL contamination problem.

If they really wanna go that ugly route ... just let them go.
I don't see where I could care at all.

As I'm primarily concerned w/ embedded systems, I'll need full
documentation and control over the device, I won't trust vendor DTBs
anyways. And I won't help people doing crippled proprietary stuff,
not at this critical point.

Even for larger systems - except the crippled x86 world - I won't even
allow any proprietary bootloader/firmware.



cu
--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f?r einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist ausschlie?lich f?r denjenigen bestimmt, an den sie gerichtet worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d?rfen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrt?mlich erhalten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachricht antworten. Bitte l?schen Sie in diesem Fall diese Nachricht und alle Anh?nge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged information. It is intended only for the person it was addressed to. If you are not the intended recipient of this email you may not copy, forward, disclose or otherwise use it or any part of it in any form whatsoever. If you received this email in error please notify the sender by replying and delete this message and any attachments without retaining a copy.
