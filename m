From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 16:28:46 +0100
Subject: [PATCH 10/25] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
In-Reply-To: <570F0C7D.8000004@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-11-git-send-email-ynorov@caviumnetworks.com>
 <570F0C7D.8000004@huawei.com>
Message-ID: <20160422152845.GO2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 11:20:29AM +0800, Zhangjian (Bamvor) wrote:
> I suggest we enable AARCH32_EL0 by default explicitly. I am not sure
> if it should be a dedicated commit. I am ok if you merge my commit, add

We currently enable COMPAT in defconfig. I think we keep the same
approach and change CONFIG_COMPAT to CONFIG_AARCH32_EL0 in defconfig.

-- 
Catalin
