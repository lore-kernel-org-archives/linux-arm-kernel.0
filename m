From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 4 Apr 2014 14:30:49 +0530
Subject: [PATCH 00/17] ARM: exynos: cpuidle: Move the driver to
 drivers/cpuidle
In-Reply-To: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAK9yfHyqysyXMWURUAScXWgVoXUYJqtYH2Z7_jkqYO4W0z+siw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 4 April 2014 13:17, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> This patchset relies on the cpm_pm notifier to initiate the powerdown sequence
> operations from pm.c instead cpuidle.c. Thus the cpuidle driver is no longer
> dependent from arch specific code as everything is called from the pm.c file.
>
> The patchset applies on top of v3.14.

It would be good to have this patch series based on Kukjin's for-next
which has several
changes like code refactoring and consolidation including Tomasz
Figa's PM consolidation
patches applied and would be merged in 3.15-rc1 release.

-- 
With warm regards,
Sachin
