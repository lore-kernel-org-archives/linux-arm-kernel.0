From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 12 Sep 2015 12:38:45 -0700
Subject: [PATCH] ARM: BCM5301X: add NAND flash chip description for Asus
 RT-AC87U
In-Reply-To: <1442056656-11491-1-git-send-email-hauke@hauke-m.de>
References: <1442056656-11491-1-git-send-email-hauke@hauke-m.de>
Message-ID: <55F47F45.9010605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/12/15 04:17, Hauke Mehrtens a ?crit :
> The NAND flash chip description were not imported for the Asus RT-AC87U
> dts file when this was done for all the other dts files, because these
> patches were send in parallel.
> 
> This adds a missing NAND flash chip description to this patch:
> commit 9faa5960eef3204cae6637b530f5e23e53b5a9ef
> Author: Hauke Mehrtens <hauke@hauke-m.de>
> Date: Fri May 29 23:39:47 2015 +0200
> 
> ARM: BCM5301X: add NAND flash chip description
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied to devicetree/next, thanks!
-- 
Florian
