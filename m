From: weigelt@melag.de (Enrico Weigelt, metux IT consult)
Date: Thu, 28 May 2015 14:35:37 +0200
Subject: imx53 IPU support on 4.0.4
In-Reply-To: <CAOMZO5CTz4DOdB6xvrw1=i4DRsukQjtzyDMJn50znXd6uXMBUA@mail.gmail.com>
References: <555C86A5.2030007@melag.de>
 <CAOMZO5CTz4DOdB6xvrw1=i4DRsukQjtzyDMJn50znXd6uXMBUA@mail.gmail.com>
Message-ID: <55670B99.30103@melag.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 20.05.2015 um 15:21 schrieb Fabio Estevam:

Hi,

>> (Haven't 4.1rc* yet, as it broke some other things for me.)
>
> What are the regressions you see?

Trouble w/ emmc/sd suddenly being ro.
Guess, something in with the corresponding APIs changed and I
didn't rebase correctly.

It's now several weeks ago (IIRC, on rc1) - I'm currently rebasing
everything again to the recent master.


cu
--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f?r einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist ausschlie?lich f?r denjenigen bestimmt, an den sie gerichtet worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d?rfen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrt?mlich erhalten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachricht antworten. Bitte l?schen Sie in diesem Fall diese Nachricht und alle Anh?nge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged information. It is intended only for the person it was addressed to. If you are not the intended recipient of this email you may not copy, forward, disclose or otherwise use it or any part of it in any form whatsoever. If you received this email in error please notify the sender by replying and delete this message and any attachments without retaining a copy.
