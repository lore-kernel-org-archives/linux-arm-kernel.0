From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 1 May 2015 12:26:09 +0200 (CEST)
Subject: [PATCH 0/2] regulator: Add regulator driver for the MC34708 PMIC
In-Reply-To: <20150428141736.16243.57292.stgit@localhost>
References: <20150428141736.16243.57292.stgit@localhost>
Message-ID: <62238108.776606.1430475969692.JavaMail.open-xchange@oxbaltgw07.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

> Martin Fuzzey <mfuzzey@parkeon.com> hat am 28. April 2015 um 16:17
> geschrieben:
>
>
> Add regulator driver and associated DT bindings for the regulators in the
> Freescale MC34708 PMIC.

from my understanding this PMIC is used typically for i.MX50/53 SoCs. So in this
case
it would make sense to mention it here and CC this patch series also to the IMX
maintainers.

Btw 

git format-patch --cover-letter

is your friend.

Stefan

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
