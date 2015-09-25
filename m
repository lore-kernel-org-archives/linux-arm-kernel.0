From: weigelt@melag.de (Enrico Weigelt, metux IT consult)
Date: Fri, 25 Sep 2015 13:14:23 +0200
Subject: [RFC PATCH] ARM: enable highmem by default on ARMv6/ARMv7 CPUs
In-Reply-To: <E1Zbx08-0001A3-PQ@rmk-PC.arm.linux.org.uk>
References: <E1Zbx08-0001A3-PQ@rmk-PC.arm.linux.org.uk>
Message-ID: <56052C8F.8030705@melag.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.09.2015 um 22:38 schrieb Russell King:
> ARMv6 and ARMv7 normally have more than 1G of memory, so it makes sense
> to have highmem enabled by default.  Users can still turn highmem off if
> they wish by enabling the EXPERT option, which then allows the option to
> be visible.

I just got a new TX6 (Karo) machine - only a few of their SoM's
even have 1G - most of them just 1/4 or 1/2.

Most embedded boxes I know (not counting smartphones) are way
beyond 1G, so I have a bad feeling w/ your proposal.


--mtx

--
Enrico Weigelt, metux IT consult
+49-151-27565287
[Facebook]<https://www.facebook.com/MELAG.Medizintechnik> [Youtube] <https://www.youtube.com/channel/UCm3er2LyByOAioiOA3zcwJg>  [Xing] <https://www.xing.com/companies/melagmedizintechnikohg>  [Linkedin] <https://linkedin.com/company/melag-medical-technology>

MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f?r einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist ausschlie?lich f?r denjenigen bestimmt, an den sie gerichtet worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d?rfen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrt?mlich erhalten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachricht antworten. Bitte l?schen Sie in diesem Fall diese Nachricht und alle Anh?nge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged information. It is intended only for the person it was addressed to. If you are not the intended recipient of this email you may not copy, forward, disclose or otherwise use it or any part of it in any form whatsoever. If you received this email in error please notify the sender by replying and delete this message and any attachments without retaining a copy.
