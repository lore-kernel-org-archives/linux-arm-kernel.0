From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Feb 2013 15:52:02 +0530
Subject: [PATCH, RFC 1/8] ARM: localtimer: return percpu clkevt on register
In-Reply-To: <e7cbb10903841ba23a93f71e7a06ae34a43adc70.1361186097.git.afzal@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
 <e7cbb10903841ba23a93f71e7a06ae34a43adc70.1361186097.git.afzal@ti.com>
Message-ID: <5123524A.9080300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 February 2013 05:06 PM, Afzal Mohammed wrote:
> Return percpu clock event on local timer register. It is the boot cpu
> that calls this and it can use the returned percpu clock event to
> register a clock event in the case of SMP configuration with one core.
SMP configuration with 1 core is UP :-)
Jokes apart as said already, lets see whether we really need it.

Regards,
Santosh
