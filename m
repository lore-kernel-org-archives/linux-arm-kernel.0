From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 06 Dec 2013 10:43:39 -0700
Subject: [PATCH 1/2] ARM: tegra: rebuild tegra_defconfig
In-Reply-To: <20131206152225.GF32372@ulmo.nvidia.com>
References: <1386196073-25193-1-git-send-email-swarren@wwwdotorg.org>
 <20131206152225.GF32372@ulmo.nvidia.com>
Message-ID: <52A20CCB.20802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2013 08:22 AM, Thierry Reding wrote:
> On Wed, Dec 04, 2013 at 03:27:52PM -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>> 
>> This separates out "NULL" changes from future real changes.
>> 
>> Signed-off-by: Stephen Warren <swarren@nvidia.com> --- 
>> arch/arm/configs/tegra_defconfig | 12 ++++-------- 1 file
>> changed, 4 insertions(+), 8 deletions(-)
> 
> Not sure if this makes sense for what's essentially a
> machine-generated change, but I've at least verified that this
> doesn't drop anything unwanted, so:

Well, the purpose was to make the real change in patch 2/2 obvious, so
it was easier to review. defconfig changes all get squashed back
together when applied.
