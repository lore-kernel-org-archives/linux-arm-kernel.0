From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 May 2013 09:19:43 -0600
Subject: [v2 0/6] CLK: tegra: convert device tree files to use CLK defines
In-Reply-To: <20130522091248.b3acd9c56ab66535d75b8fd1@nvidia.com>
References: <1369127450-15203-1-git-send-email-hdoyu@nvidia.com>
 <519B9B5D.4050402@wwwdotorg.org>
 <20130522091248.b3acd9c56ab66535d75b8fd1@nvidia.com>
Message-ID: <519CE20F.8020203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2013 12:12 AM, Hiroshi Doyu wrote:
> On Tue, 21 May 2013 18:05:49 +0200
> Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>> On 05/21/2013 03:10 AM, Hiroshi Doyu wrote:
>>> This patchset converts device tree files to use CLK defines. This
>>> version was updated along with the latest DT changes.
>>>
>>> The following changes since commit 7479d8bb5650f43053d0e82fa44db668cf968f11:
>>>
>>>   TESTING: Build Tegra USB as a module (2013-05-20 13:11:19 -0600)
>>
>> That commit is in my personal work-in-progress branch. This series
>> should be based on Tegra's for-3.11/dt branch. This will make a
>> difference (at least) in patch 6/6, where you've edited some DT nodes
>> that don't yet exist upstream (i.e. Tegra's for-3.11/dt branch) and
>> hence this series won't apply there.
> 
> I'll rebase.
> 
>> I assume you're planning to send a series for 3.11 that converts
>> drivers/clk/tegra/ to use these new header files?
> 
> I think that I'll work on SMMU first, which diverted from the
> downstream now. So the above may come a bit later.

Really? SMMU support upstream is pretty low priority right now since we
don't use it yet, and only converting one of the two potential users of
this new binding header file means it isn't particularly useful.
