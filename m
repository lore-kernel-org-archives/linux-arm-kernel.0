From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Apr 2012 10:01:07 -0600
Subject: [PATCH] pinctrl: tegra: debugfs enhancements
In-Reply-To: <CACRpkdYiWTNQ7hVM4NczyemxOcHWNcK639-yoh2iWc-5_WQB2Q@mail.gmail.com>
References: <1334184439-16428-1-git-send-email-swarren@wwwdotorg.org>
 <CACRpkdYiWTNQ7hVM4NczyemxOcHWNcK639-yoh2iWc-5_WQB2Q@mail.gmail.com>
Message-ID: <4F884DC3.70800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2012 06:46 AM, Linus Walleij wrote:
> On Thu, Apr 12, 2012 at 12:47 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> * Only provide debugfs-relates ops when CONFIG_DEBUG_FS is enabled.
>> * Implement pin_config_group_dbg_show op.
>> * Implement pin_config_config_dbg_show op.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> Linus, this too would be best to take through the Tegra tree. It depends
>> on the other two patches I just posted, but to satisfy that, I'll just
>> base my branch off of pinctrl once you've applied those branches and its
>> stable.
> 
> OK that means you need that other patch adding the debug callback to
> be in some stable branch so you can pull it into the Tegra
> tree I guess?
> 
> Can we conclude base stabilization from this and say that the series
> of patches upto debugfs enhancements v2 (with the kerneldoc fix)
> is the stable merge base, and I'll push some tag for that.

Sounds good to me.

> And once that settles:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks.
