From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 22 Mar 2013 15:25:39 -0700
Subject: [PATCH REPOST v2] clk: add table lookup to mux
In-Reply-To: <514CC21E.40206@wwwdotorg.org>
References: <1363954078-29952-1-git-send-email-pdeschrijver@nvidia.com>
 <514C813E.1070603@wwwdotorg.org> <20130322202522.834.24639@quantum>
 <514CC21E.40206@wwwdotorg.org>
Message-ID: <20130322222539.834.66626@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2013-03-22 13:42:06)
> On 03/22/2013 02:25 PM, Mike Turquette wrote:
> > Quoting Stephen Warren (2013-03-22 09:05:18)
> >> On 03/22/2013 06:07 AM, Peter De Schrijver wrote:
> >>> Add a table lookup feature to the mux clock. Also allow arbitrary masks
> >>> instead of the width. This will be used by some clocks on Tegra114. Also
> >>> adapt the tegra periph clk because it uses struct clk_mux directly.
> >>>
> >>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> >>
> >> Tested-by: Stephen Warren <swarren@nvidia.com>
> > 
> > Thanks for the patch.  Taken into clk-next.
> 
> Great. Recall this is a dependency for the Tegra114 clock series that I
> was planning on taking through the Tegra tree. Should I just merge your
> whole clk-next into the Tegra tree as a basis for the Tegra114 clock
> branch, or should this one patch be put into a separate topic branch so
> I don't pick up everything? The latter would reduce the
> inter-dependencies, and allow the merge to happen earlier. Obviously,
> I'll wait until you let me know the appropriate branch is stable before
> doing the merge. Thanks.

I want to get a little more exposure in linux-next before I create a
branch named clk-for-3.10 will never be rebased.  Assuming there are no
issues then probably the middle of next week I will push commit ce4f3313
and it will be considered immutable.

As always the tip of clk-next might be rebased, but never past the top
commit in the clk-for-x.y commit, which is frozen.

Regards,
Mike
