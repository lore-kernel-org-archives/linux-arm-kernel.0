From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 10 Jul 2017 08:54:49 -0700
Subject: [PATCH 6/6] irqchip: brcmstb-l2: Add support for the BCM7271 L2
 controller
In-Reply-To: <20170707192016.13001-7-opendmb@gmail.com>
References: <20170707192016.13001-1-opendmb@gmail.com>
 <20170707192016.13001-7-opendmb@gmail.com>
Message-ID: <cdf386bc-84ad-392c-098f-fa1558cbcf1b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2017 12:20 PM, Doug Berger wrote:
> Add the initialization of the generic irq chip for the BCM7271 L2
> interrupt controller.  This controller only supports level
> interrupts and uses the "brcm,bcm7271-l2-intc" compatibility
> string.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
