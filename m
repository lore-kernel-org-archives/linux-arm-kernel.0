From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 May 2012 13:58:38 -0600 (MDT)
Subject: [PATCH] OMAP4+: hwmod: fix issue causing IPs not going back to
 Smart-Standby
In-Reply-To: <1334926326-26437-1-git-send-email-d-elaidi@ti.com>
References: <1334926326-26437-1-git-send-email-d-elaidi@ti.com>
Message-ID: <alpine.DEB.2.00.1205241358260.2572@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Apr 2012, Djamil Elaidi wrote:

> If an IP is configured in Smart-Standby-Wakeup, when disabling wakeup feature the
> IP will not go back to Smart-Standby, but will remain in Smart-Standby-Wakeup.
> 
> Signed-off-by: Djamil Elaidi <d-elaidi@ti.com>

Thanks, queued for 3.5-rc fixes.


- Paul
