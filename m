From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Jan 2013 11:25:09 -0700
Subject: [PATCH] ARM: tegra: fix compile error when disable CPU_IDLE
In-Reply-To: <1359095912-32455-1-git-send-email-josephl@nvidia.com>
References: <1359095912-32455-1-git-send-email-josephl@nvidia.com>
Message-ID: <5106C285.8020203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 11:38 PM, Joseph Lo wrote:
> The "sleep.S" file has many functions that be shared by different module
> currently. Not just for CPU idle driver. Make it build as default now.

I've applied this to Tegra's for-3.9/cleanup branch.
