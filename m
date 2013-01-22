From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Jan 2013 18:46:34 +0000
Subject: [v3 2/2] ARM: tegra: Skip scu_enable(scu_base) if not Cortex A9
In-Reply-To: <50FEDC0B.7050604@wwwdotorg.org>
References: <1358833924-24535-1-git-send-email-hdoyu@nvidia.com>
 <1358833924-24535-2-git-send-email-hdoyu@nvidia.com>
 <50FEDC0B.7050604@wwwdotorg.org>
Message-ID: <20130122184633.GI2153@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephan,

On Tue, Jan 22, 2013 at 06:35:55PM +0000, Stephen Warren wrote:
> On 01/21/2013 10:52 PM, Hiroshi Doyu wrote:
> > Skip scu_enable(scu_base) if CPU is not Cortex A9 with SCU.
> 
> Will, is your for-next/perf branch stable; can I pull it into a branch
> destined for arm-soc? Background below:

I'm going to send a pull request to Russell tomorrow using my for-rmk/perf
branch, so *that* is stable. You might, however, want to wait for Russell to
push that out because it's also needed for kvm and, as such, will need to
be published anyway.

Sound ok?

Will
