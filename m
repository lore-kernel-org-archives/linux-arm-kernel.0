From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 26 Nov 2015 16:04:01 +0530
Subject: [PATCH 06/14] ARM: am437x: cm-t43: dts: add dual emac support
In-Reply-To: <1448371155-17307-7-git-send-email-nikita@compulab.co.il>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
 <1448371155-17307-7-git-send-email-nikita@compulab.co.il>
Message-ID: <5656E019.3000903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 November 2015 06:49 PM, Nikita Kiryanov wrote:
> CM-T43 comes with 2 ethernet ports connected to the cpsw subsystem, which
> has 2 modes of operation: switch mode and dual emac mode.
> Add the relevant muxing and set it up to work in dual emac mode by
> default.
> 
> Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>

Acked-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
