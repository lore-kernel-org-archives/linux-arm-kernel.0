From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 9 Mar 2017 12:33:46 -0800
Subject: [PATCH 2/2] ARM: dts: BCM5301X: Don't use nonexistent
 "default-off" LED trigger
In-Reply-To: <20170308064105.26619-2-zajec5@gmail.com>
References: <20170308064105.26619-1-zajec5@gmail.com>
 <20170308064105.26619-2-zajec5@gmail.com>
Message-ID: <b0dc618c-5fd3-e2a0-570d-bbd901a2d137@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2017 10:41 PM, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> Such a trigger doesn't exist in Linux and is not needed as LED is being
> turned off by default. This could cause errors in LEDs core code when
> trying to set default trigger.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

Applied, thanks!
-- 
Florian
