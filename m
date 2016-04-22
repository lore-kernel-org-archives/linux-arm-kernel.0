From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Apr 2016 12:00:37 -0600
Subject: [PATCH v2] ARM: dts: tegra: correct Beaver pinmux
In-Reply-To: <20160422114642.GD9047@ulmo.ba.sec>
References: <1456514310-27605-1-git-send-email-dev@lynxeye.de>
 <20160422114642.GD9047@ulmo.ba.sec>
Message-ID: <571A66C5.8070609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2016 05:46 AM, Thierry Reding wrote:
> On Fri, Feb 26, 2016 at 08:18:30PM +0100, Lucas Stach wrote:
>> Update pinmux to get rid of invalid uses of the rsvd1 function, which lead
>> to the mux settings on those pins to not be applied.
>>
>> Also add correct drive settings, derived from the Tegra3 TRM, for SDIO1,
>> which makes some more SD-cards work.
>>
>> Signed-off-by: Lucas Stach <dev@lynxeye.de>
>> ---
>>   arch/arm/boot/dts/tegra30-beaver.dts | 39 ++++++++++++++++++++++--------------
>>   1 file changed, 24 insertions(+), 15 deletions(-)
>
> Applied, thanks.
>
> Stephen, you had looked at this before. If you're happy with it, would
> you mind providing an Acked-by? I can apply it after the fact.

Acked-by: Stephen Warren <swarren@nvidia.com>

This appears to match a recent change in tegra-pinmux-scripts.git.
