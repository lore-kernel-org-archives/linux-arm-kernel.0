From: trini@ti.com (Tom Rini)
Date: Tue, 24 Jun 2014 16:51:24 -0400
Subject: [PATCH v3 1/2] arm: dts: am4372: let boards access all nodes
 through phandles
In-Reply-To: <1403547659-24558-2-git-send-email-balbi@ti.com>
References: <1403547659-24558-1-git-send-email-balbi@ti.com>
 <1403547659-24558-2-git-send-email-balbi@ti.com>
Message-ID: <53A9E4CC.4050409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2014 02:20 PM, Felipe Balbi wrote:
> by providing phandles to rtc, wdt, cpu and dispc nodes,
> boards can access them to add board-specific data.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Tested-by: Tom Rini <trini@ti.com>

-- 
Tom
