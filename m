From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 19 May 2016 11:49:26 +0100
Subject: [PATCH] arm64: cpuinfo: add AArch64 & elf platform for app
 compatibility
In-Reply-To: <1463625873-60016-1-git-send-email-saberlily.xia@hisilicon.com>
References: <1463625873-60016-1-git-send-email-saberlily.xia@hisilicon.com>
Message-ID: <20160519104925.GL22378@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2016 at 10:44:33AM +0800, x00195127 wrote:
> we find that some apps will read cpuinfo when start up,
> they need the string  as follows:
> "Processor       : AArch64 Processor rev 0 (aarch64)"
> 
> Then thay could load the corresponding libs. But now
> arm64 platform's cpuinfo don't has this now, so
> we need add this.

I have the same question as Martinez: what are those apps? If they are
64-bit apps, they can always assume AArch64 processor.

-- 
Catalin
