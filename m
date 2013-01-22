From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Jan 2013 11:49:59 -0700
Subject: [v3 2/2] ARM: tegra: Skip scu_enable(scu_base) if not Cortex
 A9
In-Reply-To: <20130122184633.GI2153@mudshark.cambridge.arm.com>
References: <1358833924-24535-1-git-send-email-hdoyu@nvidia.com>
 <1358833924-24535-2-git-send-email-hdoyu@nvidia.com>
 <50FEDC0B.7050604@wwwdotorg.org>
 <20130122184633.GI2153@mudshark.cambridge.arm.com>
Message-ID: <50FEDF57.1060204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2013 11:46 AM, Will Deacon wrote:
> Hi Stephan,
> 
> On Tue, Jan 22, 2013 at 06:35:55PM +0000, Stephen Warren wrote:
>> On 01/21/2013 10:52 PM, Hiroshi Doyu wrote:
>>> Skip scu_enable(scu_base) if CPU is not Cortex A9 with SCU.
>>
>> Will, is your for-next/perf branch stable; can I pull it into a branch
>> destined for arm-soc? Background below:
> 
> I'm going to send a pull request to Russell tomorrow using my for-rmk/perf
> branch, so *that* is stable. You might, however, want to wait for Russell to
> push that out because it's also needed for kvm and, as such, will need to
> be published anyway.
> 
> Sound ok?

I'm assuming rmk's branch will be a stable base, so that sounds great,
thanks.
