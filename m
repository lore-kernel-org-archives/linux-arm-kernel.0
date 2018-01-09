From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 9 Jan 2018 12:09:38 +0000
Subject: [PATCH v3] dt: psci: Update DT bindings to support hierarchical
 PSCI states
In-Reply-To: <1515498913-24291-1-git-send-email-ulf.hansson@linaro.org>
References: <1515498913-24291-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <18b1d849-038d-f768-99aa-b363e4c8b2f8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Removed Brendan Jackman as he is no longer works in ARM)

On 09/01/18 11:55, Ulf Hansson wrote:
> From: Lina Iyer <lina.iyer@linaro.org>
> 
> Update DT bindings to represent hierarchical CPU and CPU domain idle states
> for PSCI. Also update the PSCI examples to clearly show how flattened and
> hierarchical idle states can be represented in DT.
> 

It now looks good to me :)

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
