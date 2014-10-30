From: rogerq@ti.com (Roger Quadros)
Date: Thu, 30 Oct 2014 16:27:25 +0200
Subject: [PATCH 07/10] ARM: OMAP2+: Require proper GPMC timings for devices
In-Reply-To: <1414628948-30702-8-git-send-email-tony@atomide.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
 <1414628948-30702-8-git-send-email-tony@atomide.com>
Message-ID: <54524ACD.2030406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2014 02:29 AM, Tony Lindgren wrote:
> Now that we have timings in the .dts files for smc91x
> and 8250, we can remove the device specific checks and
> just print out the bootloader timings for devices that
> may not have timings in the .dts files.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
