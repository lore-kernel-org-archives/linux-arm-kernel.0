From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 14 May 2012 10:26:09 -0600
Subject: [PATCH] ARM: tegra: Fix flow controller accesses
In-Reply-To: <1336991229-18859-1-git-send-email-pdeschrijver@nvidia.com>
References: <1336991229-18859-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <4FB13221.3000704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2012 04:27 AM, Peter De Schrijver wrote:
> flowctrl_write_cpu_csr uses the cpu halt offsets and vice versa. This patch
> fixes this bug.
> 
> Reported-by: Dan Willemsen <dwillemsen@nvidia.com>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Applied, thanks.

I fixed the patch description to mention when this problem was introduced.

I'll send a pull request to include this in 3.4-final in a second.
