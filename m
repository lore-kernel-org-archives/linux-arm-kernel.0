From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 16 Sep 2014 16:04:35 +0000 (UTC)
Subject: [PATCH 01/12] ARM: OMAP2+: Add hwmod flag for
 HWMOD_RECONFIG_IO_CHAIN
In-Reply-To: <1410837126-31553-1-git-send-email-tony@atomide.com>
References: <1410837126-31553-1-git-send-email-tony@atomide.com>
Message-ID: <alpine.DEB.2.02.1409161604160.23518@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Sep 2014, Tony Lindgren wrote:

> Commit cc824534d4fe ("ARM: OMAP2+: hwmod: Rearm wake-up interrupts
> for DT when MUSB is idled") fixed issues with hung UART wake-up
> events by calling _reconfigure_io_chain() when MUSB is connected
> or disconnected.
> 
> As pointed out by Paul Walmsley, we may need to also call
> _reconfigure_io_chain() in other cases, so it should be a separate
> flag. Let's add HWMOD_RECONFIG_IO_CHAIN as suggested by Paul.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>

Thanks for taking care of this.


- Paul
