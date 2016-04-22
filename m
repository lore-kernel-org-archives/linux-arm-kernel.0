From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 22 Apr 2016 12:01:16 -0700
Subject: [PATCH] ARM: BCM5301X: Add DT entry for SPI controller and NOR
 flash
In-Reply-To: <1461049006-22818-1-git-send-email-zajec5@gmail.com>
References: <1461049006-22818-1-git-send-email-zajec5@gmail.com>
Message-ID: <571A74FC.904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/16 23:56, Rafa? Mi?ecki wrote:
> Controller is present on every BCM4708* board but only few devices have
> serial flash attached so mark it as disabled by default.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>

Applied to devicetree/next, thanks!
-- 
Florian
