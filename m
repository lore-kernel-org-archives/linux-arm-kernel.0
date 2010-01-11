From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2010 23:45:40 +0000
Subject: [RFC 08/18] arm: msm: set L2CR1 to enable prefetch and burst
	on Scorpion.
In-Reply-To: <1263250057-26692-9-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-9-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100111234540.GN7925@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 02:47:27PM -0800, Daniel Walker wrote:
> From: Larry Bassel <lbassel@quicinc.com>
> 
> This change improves the following LMBench benchmarks
> by over 15%:

Is this something that could be done in the platform initialisation code
rather than the processor code?  It's clearly not specific to all ARMv7
CPUs.
