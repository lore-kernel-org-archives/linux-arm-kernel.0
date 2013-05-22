From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 May 2013 09:20:04 -0600
Subject: [v2 0/6] CLK: tegra: convert device tree files to use CLK defines
In-Reply-To: <20130522.130730.1153046210420942555.hdoyu@nvidia.com>
References: <1369127450-15203-1-git-send-email-hdoyu@nvidia.com><519B9B5D.4050402@wwwdotorg.org><20130522091248.b3acd9c56ab66535d75b8fd1@nvidia.com>
 <20130522.130730.1153046210420942555.hdoyu@nvidia.com>
Message-ID: <519CE224.3010107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2013 04:07 AM, Hiroshi Doyu wrote:
> Hiroshi Doyu <hdoyu@nvidia.com> wrote @ Wed, 22 May 2013 08:12:48 +0200:
> 
>> On Tue, 21 May 2013 18:05:49 +0200
>> Stephen Warren <swarren@wwwdotorg.org> wrote:
>>
>>> On 05/21/2013 03:10 AM, Hiroshi Doyu wrote:
>>>> This patchset converts device tree files to use CLK defines. This
>>>> version was updated along with the latest DT changes.
>>>>
>>>> The following changes since commit 7479d8bb5650f43053d0e82fa44db668cf968f11:
>>>>
>>>>   TESTING: Build Tegra USB as a module (2013-05-20 13:11:19 -0600)
>>>
>>> That commit is in my personal work-in-progress branch. This series
>>> should be based on Tegra's for-3.11/dt branch. This will make a
>>> difference (at least) in patch 6/6, where you've edited some DT nodes
>>> that don't yet exist upstream (i.e. Tegra's for-3.11/dt branch) and
>>> hence this series won't apply there.
>>
>> I'll rebase.
> 
> Rebased on Tegra's for-3.11/dt, including fix: [2/6] over 80 columns.
> 
> If you want me to send patches again, please let me know.

Yes, you should always send the patches for review on mailing lists.
