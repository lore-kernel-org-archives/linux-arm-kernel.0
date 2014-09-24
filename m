From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 24 Sep 2014 09:03:35 -0500
Subject: [PATCH v6 2/5] arm: dts: qcom: Add SPM device bindings for 8974
In-Reply-To: <20140924134939.GA422@ilina-mac>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
 <1411516281-58328-3-git-send-email-lina.iyer@linaro.org>
 <5422621E.2050509@smartplayin.com> <20140924134939.GA422@ilina-mac>
Message-ID: <714DF939-F8F4-4CB3-817A-16FA43E5A2C7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 24, 2014, at 8:49 AM, Lina Iyer <lina.iyer@linaro.org> wrote:

> On Wed, Sep 24 2014 at 00:14 -0600, Pramod Gurav wrote:
>> Hi Lina,
>> 
>> On Wednesday 24 September 2014 05:21 AM, Lina Iyer wrote:
>>> Add SPM device bindings for QCOM 8974 based cpus. SPM is the sub-system
>>> power manager and controls the logic around the cores (cpu and L2).
>>> 
>>> Each core has an instance of SPM and controls only that core. Each cpu
>>> SPM is configured to support WFI and SPC (standalone-power collapse).
>>> 
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> ---
>>> arch/arm/boot/dts/qcom-msm8974-pm.dtsi | 69 ++++++++++++++++++++++++++++++++++
>>> arch/arm/boot/dts/qcom-msm8974.dtsi    | 10 +++--
>>> 2 files changed, 75 insertions(+), 4 deletions(-)
>>> create mode 100644 arch/arm/boot/dts/qcom-msm8974-pm.dtsi

please also have a dts for 8084 as part of this patch series.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
