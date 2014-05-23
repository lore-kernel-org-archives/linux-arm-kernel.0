From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 May 2014 15:29:33 +0100
Subject: [PATCHv2 0/6] arm64:lib: the optimized string library routines
 for armv8 processors
In-Reply-To: <5375F8C6.1030907@linaro.org>
References: <1398661895-5559-1-git-send-email-zhichang.yuan@linaro.org>
 <20140509125617.GD7950@arm.com> <5375F8C6.1030907@linaro.org>
Message-ID: <20140523142933.GM9252@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 12:38:46PM +0100, zhichang.yuan wrote:
> On 2014?05?09? 20:56, Catalin Marinas wrote:
> > On Mon, Apr 28, 2014 at 06:11:28AM +0100, zhichang.yuan at linaro.org wrote:
> >> * Done LTP on big-endian and little-endian system according to
> >> maintianers' requirement. The test results can be found at
> >> https://wiki.linaro.org/WorkingGroups/Kernel/ARMv8/CortexStringsTests.
> > It's not clear to me from the above page but have you done a compat
> > (AArch32) LTP test as well?
> 
> O, i missed the LTP test on compatible Aarch32 mode.
> At the moment, i have supplement these LTP tests. The LTP tests were OK.
> 
> According to the new test result, I rewrote the test report at
> https://wiki.linaro.org/WorkingGroups/Kernel/ARMv8/CortexStringsTests .

Thanks. I merged the patches and should appear in -next in the following
days. We'll run some tests as well to make sure.

BTW, I'm off for a week, so if there are any issues please talk to Will.

-- 
Catalin
