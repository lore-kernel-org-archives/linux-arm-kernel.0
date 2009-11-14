From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 14 Nov 2009 01:28:27 +0100
Subject: [PATCH v2] atmel_lcdfb Kconfig: remove long dependency line
In-Reply-To: <1258130398-13737-1-git-send-email-nicolas.ferre@atmel.com>
References: <29424085870c8c8cc3fe9d6e1f382a24f8a9ca2b.1257263893.git.nicolas.ferre@atmel.com>
	<1258130398-13737-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20091114002827.GB4441@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:39 Fri 13 Nov     , Nicolas Ferre wrote:
> Many Atmel SOC are embedding a LCD controller. This patch removes the long
> dependency line for this Atmel LCD framebuffer driver configuration entry.
> The HAVE_FB_ATMEL configuration option is located in the video Kconfig file
> as it may be setup by ARM/AT91 and AVR32 chips.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
