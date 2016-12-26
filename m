From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 26 Dec 2016 14:57:06 +0900
Subject: [PATCH 6/9] pinctrl: samsung: Replace syscore ops with standard
 platform device pm_ops
In-Reply-To: <1482495889-6201-7-git-send-email-m.szyprowski@samsung.com>
References: <CGME20161223122535epcas1p475bc33007e9ea9b206dec6d10d019d7f@epcas1p4.samsung.com>
 <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <1482495889-6201-7-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CA+Ln22G80htJ6Va4hSD7ML3=h5QKUhdHm9X3Znnj1KBjyOrROw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2016-12-23 21:24 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> Once the dependency on PMU driver (for pad retention control) has been
> removed, there is no reason to use syscore_ops based suspend/resume.

Does it also hold true for other platforms using this driver? I.e.
s3c24xx, s3c64xx and s5pv210?

Best regards,
Tomasz
