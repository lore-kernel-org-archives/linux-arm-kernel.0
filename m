From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 Mar 2015 12:07:00 +0000
Subject: [PATCH v3 2/4] arm64: dts: Add Qualcomm MSM8916 SoC and
 evaluation board dts
In-Reply-To: <20150313103453.GA3592@leverpostej>
References: <1426107080-29079-1-git-send-email-galak@codeaurora.org>
 <1426107080-29079-2-git-send-email-galak@codeaurora.org>
 <20150312170541.GE30145@leverpostej>
 <E114AF0E-5DA9-412A-B3E2-DDD95D224C66@codeaurora.org>
 <20150312182508.GF30145@leverpostej>
 <F0B0524B-AC0E-4E60-9A21-1208C4A978F5@codeaurora.org>
 <20150313103453.GA3592@leverpostej>
Message-ID: <20150313120659.GE30671@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 10:34:54AM +0000, Mark Rutland wrote:
> > > Which of spin-table/psci are you planning on using for SMP support, and
> > > when would that be likely to appear?
> > 
> > We have a qcom specific SMP enablement method for this device.  This
> > was one of our first devices so it utilized as much from arm 32-bit as
> > possible.
> 
> Implementation specific enable methods are something we really don't
> want to see for arm64.

I fully agree (and we've been stating this for over two years).

> If PSCI is out of the question then a spin-table shim in your
> bootloader shouldn't be too hard to implement.

And I guess only WFI cpuidle supported in Linux.

-- 
Catalin
