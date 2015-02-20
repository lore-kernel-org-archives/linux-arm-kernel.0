From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 19 Feb 2015 16:49:16 -0800
Subject: [PATCH 0/3] Add initial DT support for Qualcomm SPMI PMIC devices
In-Reply-To: <1422965880-11047-1-git-send-email-iivanov@mm-sol.com>
References: <1422965880-11047-1-git-send-email-iivanov@mm-sol.com>
Message-ID: <54E6848C.1090405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/15 04:17, Ivan T. Ivanov wrote:
> Following set of patches add initial DT support for PMIC devices
> found on recent Quqalcomm chipsets. Details for SPMI bus and PMIC arbiter
> could be found here [1].

Can you please put the specific compatible strings for the pmic model
into the nodes in addition to the generic "qcom,spmi-pmic"? We may want
to have regmap config tables in the future that describe the
cache/read/write abilities of the regsiters. If all we have is the
generic binding then we don't have a way to populate these tables.
Unless the plan there is to use the revid registers?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
