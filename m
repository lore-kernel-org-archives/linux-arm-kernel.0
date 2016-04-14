From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Apr 2016 09:47:28 +0100
Subject: [PATCH] arm64: Kconfig: make SCHED_MC and SCHED_SMT depend on SMP
In-Reply-To: <1460595252-2330-1-git-send-email-yang.shi@linaro.org>
References: <1460595252-2330-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20160414084727.GA23207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 05:54:12PM -0700, Yang Shi wrote:
> SCHED_MC and SCHED_SMT are pointless when SMP is disabled.
> Although SMP is rarely disabled for ARM64, it looks more consistent to have
> such depend in Kconfig.

You can't disable CONFIG_SMP for arm64 -- we select it unconditionally
in the kconfig.

Will
