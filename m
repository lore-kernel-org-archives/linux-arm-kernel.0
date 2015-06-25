From: weigelt@melag.de (Enrico Weigelt, metux IT consult)
Date: Thu, 25 Jun 2015 10:37:41 +0200
Subject: L2 Cache enable on i.MX5
In-Reply-To: <DBXPR06MB58911B5FD193722EC5BD34185AF0@DBXPR06MB589.eurprd06.prod.outlook.com>
References: <DBXPR06MB5891810D431F1AE9AEB1CE985AF0@DBXPR06MB589.eurprd06.prod.outlook.com>,
 <20150624172900.GN7557@n2100.arm.linux.org.uk>
 <DBXPR06MB58911B5FD193722EC5BD34185AF0@DBXPR06MB589.eurprd06.prod.outlook.com>
Message-ID: <558BBDD5.3020306@melag.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 25.06.2015 um 00:53 schrieb Robert Daniels:

Hi,


> In that case, where should the kernel be enabling the L2 cache? I'm using the
> 3.14 kernel for this i.MX53 product and the L2 cache is definitely not enabled.

I'm working on an mx53, too (tqma53 board), but with an 4.1 kernel.
How can I check whether L2 cache is enabled ?

Can you estimate, how much performance gain we can actually get from the
L2 cache (under which kind of workloads) ?


--mtx

--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f?r einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist ausschlie?lich f?r denjenigen bestimmt, an den sie gerichtet worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d?rfen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrt?mlich erhalten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachricht antworten. Bitte l?schen Sie in diesem Fall diese Nachricht und alle Anh?nge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged information. It is intended only for the person it was addressed to. If you are not the intended recipient of this email you may not copy, forward, disclose or otherwise use it or any part of it in any form whatsoever. If you received this email in error please notify the sender by replying and delete this message and any attachments without retaining a copy.
