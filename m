From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Sat, 12 Nov 2016 11:24:20 -0300
Subject: [PATCH v2 1/2] arm64: dts: Add level for cpu dt node for exynos7
In-Reply-To: <1478945832-1826-1-git-send-email-alim.akhtar@samsung.com>
References: <1478945832-1826-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <8a63bfe0-b23c-3583-6e5e-c17fe412e34d@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

On 11/12/2016 07:17 AM, Alim Akhtar wrote:
> This patch adds level for cpu dt node, so that these levels can be used

Do you mean s/level/label here? I'm asking because you are using level
consistently in the subject line and commit message but I'm not sure
what it means in this context.

> as a phandle whenever required. For example, adding a "interrupt-affinity"
> for arm pmu node.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---

The change looks good to me though.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
