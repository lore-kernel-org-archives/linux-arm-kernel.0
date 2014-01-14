From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 14 Jan 2014 08:04:40 -0800
Subject: [PATCH] ARM: tegra: fix tegra_powergate_sequence_power_up() inline
In-Reply-To: <20140114134225.GC10936@ulmo.nvidia.com> (Thierry Reding's
 message of "Tue, 14 Jan 2014 14:42:26 +0100")
References: <1389650502-30017-1-git-send-email-swarren@wwwdotorg.org>
 <20140114134225.GC10936@ulmo.nvidia.com>
Message-ID: <87k3e28s87.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> writes:

> On Mon, Jan 13, 2014 at 03:01:42PM -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>> 
>> Remove an invalid semicolon from the inline dummy, thus solving:
>> In file included from drivers/gpu/drm/tegra/gr3d.c:15:0:
>> include/linux/tegra-powergate.h:119:1: error: expected identifier or '(' before '{' token
>> 
>> Fixes: 80b28791ff04 ("ARM: tegra: pass reset to tegra_powergate_sequence_power_up()")
>> Reported-by: Russell King <linux@arm.linux.org.uk>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>>  include/linux/tegra-powergate.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Applied to next/soc (where the offending patch was merged), merged into
for-next, and pushed out.

Kevin
