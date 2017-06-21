From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 21 Jun 2017 09:04:26 +0530
Subject: [PATCH] arm64: topology: Get rid of "cap_parsing_done"
In-Reply-To: <20170620155400.GI21131@arm.com>
References: <9e5d20e285e04341ea1a7f43c9af2ff6d6d072dd.1497955347.git.viresh.kumar@linaro.org>
 <20170620155400.GI21131@arm.com>
Message-ID: <20170621033426.GP3942@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20-06-17, 16:54, Will Deacon wrote:
> On Tue, Jun 20, 2017 at 04:14:40PM +0530, Viresh Kumar wrote:
> > We can reuse "cap_parsing_failed" instead of keeping an additional
> > variable. Also rename cap_parsing_failed to skip_cap_parsing.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm64/kernel/topology.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> You probably need to co-ordinate with this series:
> 
> http://lkml.kernel.org/r/20170531165931.6945-5-juri.lelli at arm.com
> 
> and it would be clearer to split up the renaming part of the patch from the
> remove of the additional bool.

Thanks, I missed that series for sure :)

-- 
viresh
