From: shijie.huang@arm.com (Huang Shijie)
Date: Fri, 13 Jan 2017 10:50:38 +0800
Subject: [PATCH] arm64: hugetlb: fix the wrong return value for
 huge_ptep_set_access_flags
In-Reply-To: <20170111101924.GA18044@e104818-lin.cambridge.arm.com>
References: <1484114308-6068-1-git-send-email-shijie.huang@arm.com>
 <20170111060044.GA6112@sha-win-210.asiapac.arm.com>
 <20170111101924.GA18044@e104818-lin.cambridge.arm.com>
Message-ID: <20170113025036.GA11941@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 10:19:25AM +0000, Catalin Marinas wrote:
> The disclaimer is not the main issue. The patch that ended up on the
> list seems to have been corrupted probably by the SMTP server (all tabs
> converted to spaces).
Thanks for pointing this. I will change another SMTP server if the issue
still exists in future.

Thanks
Huang Shijie
