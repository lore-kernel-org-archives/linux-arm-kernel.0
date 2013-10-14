From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Oct 2013 20:28:29 +0200
Subject: Is next/cleanup of arm-soc tree stable?
In-Reply-To: <87mwmb930y.fsf@linaro.org>
References: <20131014161309.GG27668@S2101-09.ap.freescale.net>
 <87mwmb930y.fsf@linaro.org>
Message-ID: <525C37CD.7020604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2013 07:27 PM, Kevin Hilman wrote:
> Shawn Guo <shawn.guo@linaro.org> writes:
>
>> Olof, Kevin,
>>
>> Per reports from linux-next folks, it seems that my imx/soc branch
>> conflicts with Sebastian's clk-of-init-v2_for-3.13 quite badly.  I'm
>> considering to rebase my imx/soc branch on arm-soc next/cleanup branch
>> to solve the conflicts.  But is the branch stable, or do I have to base
>> on Sebastian's clk-of-init-v2_for-3.13 branch (assume it's stable)?
>
> Generally, the next/* branches are not stable.
>
> It would be better if you could get a commitment from Sebastian for a
> immutable branch and base directly on that.

Shawn,

I sent a PR for the above a while ago [1]. I am not going to touch this
branch at all. Compared to what will go into -next, the was a section
mismatch fixup patch for nomadik requested by Olof.

If you or Kevin want me to prepare (different) rebased branch, I can
do that. Otherwise, I suggest to just pull the existing branch as a
dependency.

Sebastian

[1] http://www.spinics.net/lists/arm-kernel/msg276175.html
