From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 31 Oct 2012 23:01:41 +0530
Subject: [PATCH V4 0/4] ARM: tegra: Enable SLINK controller driver
In-Reply-To: <50915203.8030505@wwwdotorg.org>
References: <1351674176-20603-1-git-send-email-ldewangan@nvidia.com>
 <50915203.8030505@wwwdotorg.org>
Message-ID: <5091607D.8010907@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 31 October 2012 09:59 PM, Stephen Warren wrote:
> On 10/31/2012 03:02 AM, Laxman Dewangan wrote:
>> This series modify the dts file to add the slink addresses,
>> make AUXDATA in board dt files, enable slink4 for tegra30-cardhu and
>> enable slink controller defconfig.
> I don't appear to have received patch 1/4 this time around. I'll assume
> it's identical to V3, since I don't think anything needed to change there...

Yes, it is identical to V3, no change on the 1/4.
Only change in 3/4 and 4/4. I realize later that you already applied the 
2/4 yesterday.
