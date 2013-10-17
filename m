From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Oct 2013 11:33:11 -0600
Subject: [PATCH] ARM: tegra: add clock properties for devices of Tegra124
In-Reply-To: <525464F0.5020704@wwwdotorg.org>
References: <1381218460-23123-1-git-send-email-josephl@nvidia.com>
 <525464F0.5020704@wwwdotorg.org>
Message-ID: <52601F57.4090709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2013 02:02 PM, Stephen Warren wrote:
> On 10/08/2013 01:47 AM, Joseph Lo wrote:
>> This patch adds clock properties for devices in the DT for basic support
>> of Tegra124 SoC.
> 
> This looks reasonable. I'll wait until the clock driver stuff is
> finalized and merged, then apply this on top.

Actually, I can't apply this yet, since it relies on the file
<dt-bindings/clock/tegra124-car.h>, which is being added for 3.13 in a
patch in the clock tree. This will have to wait until v3.13-rc1 or later.
