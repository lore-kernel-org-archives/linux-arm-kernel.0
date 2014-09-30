From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 30 Sep 2014 15:30:49 +0200
Subject: [PATCH v8 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <1412074969-12704-1-git-send-email-vikas.sajjan@samsung.com>
References: <1412074969-12704-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <CABxcv=kEVma+Ho6PPy+4t+zYH67sAWbbvJvrviPop-MBqktbjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vikas,

Thanks a lot for the re-spin.

On Tue, Sep 30, 2014 at 1:02 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>
> Tested on Kukjin Kim's tree, for-next branch +
> 1] http://www.spinics.net/lists/linux-samsung-soc/msg33750.html
> 2] https://lkml.org/lkml/2014/9/30/156

I wanted to test your series but I noticed that Abhilash's patch:

"[PATCH v7] ARM: EXYNOS: Use MCPM call-backs to support S2R on Exynos5420"

does not apply cleanly on Kukjin's for-next branch. I see that all the
dependencies mentioned (modulo $subject or course) have already been
merged though.

Did you rebase Abhilash's to test your series?. I can forward port as
well but just want to be sure that I'm not missing any other
dependency.

These are the patches I've on top of Kukjin's for-next branch fyi:

663dfa7 ARM: exynos5: Add Suspend-to-RAM support for 5420
b4b3b76 ARM: exynos5: Add PMU support for 5420
6c0e381 ARM: EXYNOS: Move PMU specific definitions from common.h
cdf79fe ARM: EXYNOS: Add platform driver support for Exynos PMU
d2d8bc6 mfd: syscon: Decouple syscon interface from platform devices

Best regards,
Javier
