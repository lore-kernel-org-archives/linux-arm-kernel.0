From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 1 Jun 2018 15:37:47 +0100
Subject: [PATCHv2 0/4] arm64: SMCCC conduit cleanup
In-Reply-To: <20180601142615.GU17671@n2100.armlinux.org.uk>
References: <20180531173223.9668-1-mark.rutland@arm.com>
 <20180601141410.e7dwvmqiqi2esbnk@armageddon.cambridge.arm.com>
 <20180601142615.GU17671@n2100.armlinux.org.uk>
Message-ID: <20180601143747.3axhy5a2kmxecfcs@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 03:26:16PM +0100, Russell King wrote:
> On Fri, Jun 01, 2018 at 03:14:10PM +0100, Catalin Marinas wrote:
> > On Thu, May 31, 2018 at 06:32:19PM +0100, Mark Rutland wrote:
> > > Mark Rutland (4):
> > >   arm/arm64: smccc/psci: add arm_smccc_1_1_get_conduit()
> > >   arm64: errata: use arm_smccc_get_conduit()
> > >   firmware/psci: use common SMCCC_CONDUIT_*
> > >   firmware: arm_sdei: use common SMCCC_CONDUIT_*
> > 
> > Queued for 4.18. Thanks.
> 
> Have you considered how this affects the 32-bit ARM spectre stuff, which
> makes use of the firmware PSCI interfaces for the workaround?

No, I haven't. Thanks for the heads up. Talking to Mark, I think it's
best if I drop this series for now.

-- 
Catalin
