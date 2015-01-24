From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 24 Jan 2015 20:06:14 +0000 (UTC)
Subject: [PATCH 16/23] ARM: OMAP4: omapdss: remove legacy pad muxing
 support
In-Reply-To: <1417103514-17027-17-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
 <1417103514-17027-17-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1501242005550.5450@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Nov 2014, Tero Kristo wrote:

> OMAP4 is DT only now, so the legacy mux support is not needed anymore.
> Padconf is used instead from the driver / DT. This removes the need
> for having the mux APIs exported from the control module driver.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Dropping since Tomi mentioned legacy mux support is still in use.


- Paul
