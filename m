From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Mar 2018 17:19:15 +0000
Subject: [PATCH v6 00/25] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
In-Reply-To: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20180314171914.tdwtppsvjsgxiqlv@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Wed, Mar 14, 2018 at 05:58:10PM +0100, Ulf Hansson wrote:
> For ARM, the PSCI firmware interface may be managing the power to the CPUs.
> Depending on the SoC, CPUs may also be arranged in hierarchical manner, which
> could add another level of complexity from a CPU idle management point of view.
> 
> PSCI v1.0+ adds support for the so called OS initiated CPU suspend mode, which
> enables a more fine grained method, allowing Linux to get more control, in
> regards to being energy efficient. This is typically useful for these kind of
> complex battery driven platforms.

> The series is based on v4.16-rc5, but applies also as of today to Rafael's
> linux-pm.git next branch. The code has been tested on a QCOM 410c dragonboard
> and I except that test coverage should be increased by some more boards
> shortly (for ARM64 with PSCI OSI support - only a few DT changes are needed).

Do we have any numbers to show how this affects energy efficiency?

Are there any other platforms with OSI support?

Thanks,
Mark.
