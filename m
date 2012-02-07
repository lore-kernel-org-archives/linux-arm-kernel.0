From: per.fransson.ml@gmail.com (Per Fransson)
Date: Tue, 7 Feb 2012 12:07:56 +0100
Subject: [RFC] ARM: cache-l2x0.c
Message-ID: <CAMN7GVp8=iY7_Mcqra2G0dBBHFg_axiNbPfbaqycy4SGHFOV2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

In the android 3.0 kernel the workaround for PL310 errata 727915 is
applied both to:

* the clean & invalidate by way and

* the clean by way

But the errata only mentions the first of these operations. Does
anyone know if it's actually applicable to clean by way as well?

Regards,
Per
