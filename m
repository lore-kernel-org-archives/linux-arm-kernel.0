From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 May 2014 17:44:03 +0100
Subject: [PATCH v3] arm64: Support arch_irq_work_raise() via self IPIs
In-Reply-To: <1399909731-21196-1-git-send-email-larry.bassel@linaro.org>
References: <1399909731-21196-1-git-send-email-larry.bassel@linaro.org>
Message-ID: <20140516164402.GK5624@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 04:48:51PM +0100, Larry Bassel wrote:
> Support for arch_irq_work_raise() was missing from
> arm64 (a prerequisite for FULL_NOHZ).
> 
> This patch is based on the arm32 patches ARM 7872/1
> and 7887/1.

Applied (with some clean-up of the commit log). Thanks.

-- 
Catalin
