From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 May 2014 13:56:18 +0100
Subject: [PATCHv2 0/6] arm64:lib: the optimized string library routines
 for armv8 processors
In-Reply-To: <1398661895-5559-1-git-send-email-zhichang.yuan@linaro.org>
References: <1398661895-5559-1-git-send-email-zhichang.yuan@linaro.org>
Message-ID: <20140509125617.GD7950@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 06:11:28AM +0100, zhichang.yuan at linaro.org wrote:
> * Done LTP on big-endian and little-endian system according to
> maintianers' requirement. The test results can be found at
> https://wiki.linaro.org/WorkingGroups/Kernel/ARMv8/CortexStringsTests.

It's not clear to me from the above page but have you done a compat
(AArch32) LTP test as well?

Thanks.

-- 
Catalin
