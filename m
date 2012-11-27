From: markz@nvidia.com (Mark Zhang)
Date: Tue, 27 Nov 2012 11:22:45 +0800
Subject: [PATCH V2] ARM: dt: tegra: cardhu: Add drm components
In-Reply-To: <50B3F886.3090701@wwwdotorg.org>
References: <1353396472-24167-1-git-send-email-markz@nvidia.com>
 <50B3F886.3090701@wwwdotorg.org>
Message-ID: <50B43205.8020604@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2012 07:17 AM, Stephen Warren wrote:
> On 11/20/2012 12:27 AM, Mark Zhang wrote:
>> This patch adds the rgb node which is needed by
>> tegra drm driver.
> 
> This doesn't seem to include all the GPIOs/regulators/... required to
> enable the panel and backlight.
> 

Yep. Actually I don't know much about panel & backlight stuffs and I
don't submit these patches.

For panel supporting, seems right now the "Generic Panel Framework" has
been changed to version 2 and be renamed as "Common Display Framework";
For backlight, Alex's power sequence patch is on the way.

So my patch just adds the rgb node in the dts.

Mark
