From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 22 May 2014 11:38:55 -0500
Subject: [PATCH v1 3/5] clk: gcc: Add APQ8084 Global Clock Controller
 support
In-Reply-To: <1400775885-10296-4-git-send-email-gdjakov@mm-sol.com>
References: <1400775885-10296-1-git-send-email-gdjakov@mm-sol.com>
 <1400775885-10296-4-git-send-email-gdjakov@mm-sol.com>
Message-ID: <DB9EC1F3-CA2B-47C5-A677-CC1222F05614@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 22, 2014, at 11:24 AM, Georgi Djakov <gdjakov@mm-sol.com> wrote:

> This patch adds support for the global clock controller found on
> the APQ8084 based devices.
> 
> The APQ8084 and MSM8974 share a lot of clock data, so instead of
> duplicating all the data, we add support to the MSM8974 code.
> 
> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
> ---
> drivers/clk/qcom/Kconfig                     |    4 +-
> drivers/clk/qcom/gcc-msm8974.c               |  151 +++++++++++++++++++++++++-
> include/dt-bindings/clock/qcom,gcc-msm8974.h |    4 +
> 3 files changed, 154 insertions(+), 5 deletions(-)

What about differences in reset?

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
