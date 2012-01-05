From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 5 Jan 2012 15:34:29 +0000
Subject: [PATCH v3] ARM: at91: pit add DT support
In-Reply-To: <1325784348-29481-1-git-send-email-nicolas.ferre@atmel.com>
References: <1325771308-19770-1-git-send-email-nicolas.ferre@atmel.com>
 <1325784348-29481-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20120105153429.GD10530@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 06:25:48PM +0100, Nicolas Ferre wrote:
> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Retreive registers address and IRQ from device tree entry. Fall back
> to built-in values if an error occurs.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> [nicolas.ferre at atmel.com: change error path and interrupts property handling]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

Jamie
