From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 31 Oct 2012 13:16:47 -0600
Subject: [PATCH V4 0/4] ARM: tegra: Enable SLINK controller driver
In-Reply-To: <5091607D.8010907@nvidia.com>
References: <1351674176-20603-1-git-send-email-ldewangan@nvidia.com>
 <50915203.8030505@wwwdotorg.org> <5091607D.8010907@nvidia.com>
Message-ID: <5091791F.4080400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2012 11:31 AM, Laxman Dewangan wrote:
> On Wednesday 31 October 2012 09:59 PM, Stephen Warren wrote:
>> On 10/31/2012 03:02 AM, Laxman Dewangan wrote:
>>> This series modify the dts file to add the slink addresses,
>>> make AUXDATA in board dt files, enable slink4 for tegra30-cardhu and
>>> enable slink controller defconfig.
>> I don't appear to have received patch 1/4 this time around. I'll assume
>> it's identical to V3, since I don't think anything needed to change
>> there...
> 
> Yes, it is identical to V3, no change on the 1/4.

OK, I have applied the series now. Thanks.

BTW, I noticed that the Cardu board files sets the SPI controller's max
frequency to 25MHZ (which is consistent with the commit description) but
the SPI flash node's frequency to 20MHz. Was that intended, or should I
fix it up to be 25MHz?

> Only change in 3/4 and 4/4. I realize later that you already applied the
> 2/4 yesterday.

Oops, that was a mistake; I forgot to pull it out after testing and not
getting it to work. Oh well.
