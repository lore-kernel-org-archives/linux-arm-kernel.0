From: rogerq@ti.com (Roger Quadros)
Date: Thu, 30 Oct 2014 16:28:56 +0200
Subject: [PATCH 08/10] ARM: OMAP2+: Drop legacy code for gpmc-smc91x.c
In-Reply-To: <1414628948-30702-9-git-send-email-tony@atomide.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
 <1414628948-30702-9-git-send-email-tony@atomide.com>
Message-ID: <54524B28.4080005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2014 02:29 AM, Tony Lindgren wrote:
> This code was only used by 2430sdp, 3430sdp, and n900 development
> boards.
> 
> The 2430sdp is already device tree only, and all the users of the
> 3430sdp and n900 development boards are already booting in device
> tree mode, so we can drop the legacy smc91x support.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
