From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 Nov 2011 10:25:01 +0000
Subject: [PATCHv4 10/13] ARM: versatile: convert to MULTI_IRQ_HANDLER
In-Reply-To: <1320369010-23428-11-git-send-email-jamie@jamieiles.com>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
 <1320369010-23428-11-git-send-email-jamie@jamieiles.com>
Message-ID: <4EBA54FD.2010403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/11 01:10, Jamie Iles wrote:
> Now that there is a generic IRQ handler for multiple VIC devices use it
> for versatile to help building multi platform kernels.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Tested-by: Marc Zyngier <marc.zyngier@arm.com>
-- 
Jazz is not dead. It just smells funny...
