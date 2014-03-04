From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 04 Mar 2014 09:27:09 -0700
Subject: [PATCH] ARM: tegra: add LED options back into tegra_defconfig
In-Reply-To: <201402282139.40122.arnd@arndb.de>
References: <1392932240-14480-1-git-send-email-swarren@wwwdotorg.org>
 <201402282139.40122.arnd@arndb.de>
Message-ID: <5315FEDD.70407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2014 01:39 PM, Arnd Bergmann wrote:
> On Thursday 20 February 2014, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> The last time tegra_defconfig was rebuilt, various LEDs options were
>> somehow selected by other options, and hence their entries in
>> tegra_defconfig were removed by "make savedefconfig". However, for some
>> reason this is no longer happening, so we need to add the entries back
>> into tegra_defconfig so the they are enabled in .config.
>>
>> Fixes: db079b1811d1 ("ARM: tegra: rebuild tegra_defconfig to add DEBUG_FS)"
>> Reported-by: Marc Dietrich <marvin24@gmx.de>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> Another fix for 3.14.
> 
> Applied to fixes branch.

It looks like fixes isn't in linux-next. I think it'd be useful to add it.
