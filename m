From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 5 Mar 2017 17:11:32 -0800
Subject: [PATCH v2 1/3] ARM: dts: BCM5301X: Correct GIC_PPI interrupt flags
In-Reply-To: <1488500494-20622-2-git-send-email-jon.mason@broadcom.com>
References: <1488500494-20622-1-git-send-email-jon.mason@broadcom.com>
 <1488500494-20622-2-git-send-email-jon.mason@broadcom.com>
Message-ID: <01eb66cb-0359-2f58-511b-acaaf62be828@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/02/2017 04:21 PM, Jon Mason wrote:
> GIC_PPI flags were misconfigured for the timers, resulting in errors
> like:
> [    0.000000] GIC: PPI11 is secure or misconfigured
> 
> Changing them to being edge triggered corrects the issue
> 
> Suggested-by: Rafa? Mi?ecki <rafal@milecki.pl>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> Fixes: d27509f1 ("ARM: BCM5301X: add dts files for BCM4708 SoC")

Applied, thanks!
-- 
Florian
