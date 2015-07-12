From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 11 Jul 2015 18:34:13 -0700
Subject: [PATCH] ARM: BCM63xx: Remove custom secondary_startup function
In-Reply-To: <1436318221-30225-1-git-send-email-f.fainelli@gmail.com>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
 <1436318221-30225-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <55A1C415.1090109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/07/15 18:17, Florian Fainelli a ?crit :
> With commit 02b4e2756e01c623cc4dbceae4b07be75252db5b ("ARM: v7 setup
> function should invalidate L1 cache"), the default secondary_startup
> function for ARMv7 CPUs does invalidate the L1 cache, which was the sole
> reason why BCM63xx had to have its own secondary_startup implementation.
> 
> Now that the secondary_startup takes care of this, we can completely
> remove that code.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to soc/next.
-- 
Florian
