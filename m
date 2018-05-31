From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 31 May 2018 10:52:34 +0530
Subject: [PATCH 07/15] arm: dts: exynos: Add missing cooling device
 properties for CPUs
In-Reply-To: <CAJKOXPftrzwLMSDeTBBxG-nvpsriBuPEwQAViTcE3DYRYsnzmg@mail.gmail.com>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <cfd8de4b2ad1cfd7b0f1a0706c0b6b918e1ebffc.1527244201.git.viresh.kumar@linaro.org>
 <CAJKOXPcyV=fdRu7oLXHMimSFR9ktJ23uBriswTStkEkAMbTaNw@mail.gmail.com>
 <20180530043806.ksen4xyh3x3x4fqn@vireshk-i7>
 <CAJKOXPftrzwLMSDeTBBxG-nvpsriBuPEwQAViTcE3DYRYsnzmg@mail.gmail.com>
Message-ID: <20180531052234.tp6pw45ftsf3g2el@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-05-18, 14:32, Krzysztof Kozlowski wrote:
> OK, I see the possibility although it is still far away from use
> cases. You cannot hotplug booting CPU (CPU0) on Exynos kernels. It
> never worked. Strictly speaking - offlining will work. But bringing it
> online will likely hang the system.

True and I used the following out of tree patch for a long time for my
dual A15 exynos to make hotplug work.

https://git.linaro.org/people/vireshk/backup/linux.git/commit/?h=bkp/exynos/hotplug&id=aab8a906a70b8f1fb15a4b7bd2ee27e6dcabf79d

-- 
viresh
