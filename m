From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 6 Jul 2016 19:44:26 -0700
Subject: [PATCH 2/2] ARM: BCM5301X: Fix NAND ECC parameters for D-Link
 DIR-885L
In-Reply-To: <1465199036-24366-2-git-send-email-zajec5@gmail.com>
References: <1465199036-24366-1-git-send-email-zajec5@gmail.com>
 <1465199036-24366-2-git-send-email-zajec5@gmail.com>
Message-ID: <577DC20A.1050906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/06/2016 00:43, Rafa? Mi?ecki a ?crit :
> This device uses BCH-1 instead of BCH-8. This fixes ECC errors and makes
> NAND usable with brcmnand.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>

And also applied, thanks!
-- 
Florian
