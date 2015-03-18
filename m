From: agross@codeaurora.org (Andy Gross)
Date: Wed, 18 Mar 2015 01:05:10 -0500
Subject: [PATCH v16 00/11] ARM: qcom: cpuidle support for 8064, 8074, 8084
In-Reply-To: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
References: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <20150318060510.GA15705@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 04:33:40PM -0600, Lina Iyer wrote:

<snip>

> 
> Tested on: 8074, 8084.
> 

These worked fine for me on IPQ8064 (ap148), however I did have to add my own DT
entries for the idle states and saw changes.

Also tested on APQ8064 (ifc6410).

Tested-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
