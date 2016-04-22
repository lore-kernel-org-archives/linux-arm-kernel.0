From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 16:58:18 +0100
Subject: [PATCH 12/25] arm64: compat: change config dependences to aarch32
In-Reply-To: <1459894127-17698-13-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-13-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160422155818.GP2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 01:08:34AM +0300, Yury Norov wrote:
> From: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> 
> With the patches of ILP32, COMPAT is not equivalent to AARCH32 in EL0.
> This patch fix this by updating the dependency from COMPAT to
> AARCH32_EL0 for ARMV8_DEPRECATED and ARM64_ERRATUM_845719.
> 
> Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

Can you not merge patches 10-12 into a single one? They all deal with
the s/COMPAT/AARCH32_EL0/ replacement. I'm not even sure the series is
bisectable after patch 10.

-- 
Catalin
