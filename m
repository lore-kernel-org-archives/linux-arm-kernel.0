From: weigelt@melag.de (Enrico Weigelt, metux IT consult)
Date: Thu, 28 May 2015 14:31:02 +0200
Subject: Device Tree Blob (DTB) licence
In-Reply-To: <CAL_JsqKLmePHHe+4n4xwiFhjo+wZ+V774i3eY9Z07+61SDHyYQ@mail.gmail.com>
References: <1430820315.19516.26.camel@opteya.com>
 <CAL_Jsq+T5c7qornpRVCduEjUSCeM+0xqbtVYovtH76y=4BqhLQ@mail.gmail.com>
 <1432289148.5304.58.camel@opteya.com>
 <CAL_JsqKLmePHHe+4n4xwiFhjo+wZ+V774i3eY9Z07+61SDHyYQ@mail.gmail.com>
Message-ID: <55670A86.2060502@melag.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.05.2015 um 18:26 schrieb Rob Herring:

Hi,

 > Ideally, dtb files are shipped with firmware separately from the OS.
 > You should be able to run multiple OS's with that dtb. There is often
> desire or "requirements" to not have GPL code in firmware.

I dont see that begin shipped *with* the firmware (but still as a
separate object/file) automatically means a derived work.

And I actually wouldn't want dtb strictly so interewoven with the
firmware/bootloader, that it can be easily extracted or replaced
anymore. IMHO, we shouldn't support such vendors.
(freedom is more than just $0 price)

And there shouldn't be any proprietary firmware anyways.

cu
--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f?r einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist ausschlie?lich f?r denjenigen bestimmt, an den sie gerichtet worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d?rfen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrt?mlich erhalten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachricht antworten. Bitte l?schen Sie in diesem Fall diese Nachricht und alle Anh?nge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged information. It is intended only for the person it was addressed to. If you are not the intended recipient of this email you may not copy, forward, disclose or otherwise use it or any part of it in any form whatsoever. If you received this email in error please notify the sender by replying and delete this message and any attachments without retaining a copy.
