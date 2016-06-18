From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 18 Jun 2016 23:40:05 +0900
Subject: [PATCH 1/3] clk: samsung: exynos5433: prepare for adding CPU
 clocks
In-Reply-To: <1464095957-25851-2-git-send-email-b.zolnierkie@samsung.com>
References: <1464095957-25851-1-git-send-email-b.zolnierkie@samsung.com>
 <1464095957-25851-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <CA+Ln22GmeuHaNwpHOMxP0SA9-KaJp4D4sM5aF3bVRWm5Xb72fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartlomiej,

2016-05-24 22:19 GMT+09:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> Open-code samsung_cmu_register_one() calls for CMU_APOLLO and
> CMU_ATLAS setup code as a preparation for adding CPU clocks
> support for Exynos5433.

Why do we need to open code it? Even if it's really necessary, it
would make sense to state it in the commit description for lazy
readers reviewing the patches in order. :)

Best regards,
Tomasz
