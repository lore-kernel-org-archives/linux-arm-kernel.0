From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 19 Mar 2015 09:35:04 -0700
Subject: [PATCH 2/2] ARM: dts: brcmstb: add IRQ0 controller
In-Reply-To: <1426725092-16392-2-git-send-email-computersforpeace@gmail.com>
References: <1426725092-16392-1-git-send-email-computersforpeace@gmail.com>
 <1426725092-16392-2-git-send-email-computersforpeace@gmail.com>
Message-ID: <550AFAB8.9060307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/15 17:31, Brian Norris wrote:
> This L2 controller handles multiplexing a few different interrupts. We
> also need it for configuring the interrupt forwarding masks for the
> UART.
> 
> With this, we can *now* boot BCM7445 to a prompt using the upstream
> kernel + DTB.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Applied to devicetree/next, thanks!
-- 
Florian
