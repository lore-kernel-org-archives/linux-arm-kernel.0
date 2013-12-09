From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 9 Dec 2013 01:34:32 +0000 (UTC)
Subject: [PATCH 3/3] ARM: OMAP3: hwmod data: Don't prevent RESET of USB
 Host module
In-Reply-To: <1386080748-17005-4-git-send-email-rogerq@ti.com>
References: <1386080748-17005-1-git-send-email-rogerq@ti.com>
 <1386080748-17005-4-git-send-email-rogerq@ti.com>
Message-ID: <alpine.DEB.2.02.1312090134220.32309@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Dec 2013, Roger Quadros wrote:

> Unlike what the comment states, errata i660 does not state that we
> can't RESET the USB host module. Instead it states that RESET is the
> only way to recover from a deadlock situation.
> 
> RESET ensures that the module is in a known good state irrespective
> of what bootloader does with the module, so it must be done at boot.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Thanks, queued for v3.13-rc.

- Paul
