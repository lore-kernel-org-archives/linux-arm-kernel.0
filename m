From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 10 Oct 2016 01:57:32 -0700
Subject: [PATCH devicetree] ARM: BCM53573: Specify PMU and its ILP clock
 in the DT
In-Reply-To: <20160917201346.15060-1-zajec5@gmail.com>
References: <20160917201346.15060-1-zajec5@gmail.com>
Message-ID: <c6443f52-e76b-f8a0-ad00-ce0dd950081e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/17/2016 01:13 PM, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> ILP clock (sometimes called a "slow clock") is a part of PMU (Power
> Management Unit). There has been recently added a driver for it, so add
> a proper entry in the DT as well.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

Applied, thanks!
-- 
Florian
