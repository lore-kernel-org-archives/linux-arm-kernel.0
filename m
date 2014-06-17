From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jun 2014 23:48:06 +0100
Subject: [PATCH] clkdev: Don't print errors on probe defer
In-Reply-To: <20140617223305.32686.15540@quantum>
References: <1402702591-21087-1-git-send-email-sboyd@codeaurora.org>
 <20140617223305.32686.15540@quantum>
Message-ID: <20140617224805.GN23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 03:33:05PM -0700, Mike Turquette wrote:
> Quoting Stephen Boyd (2014-06-13 16:36:31)
> > This error message can spam the logs if you have lots of probe
> > deferals due to missing clocks. Just silence the error in this
> > case because the driver should try again later.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Looks OK to me. Russell?

Looks fine to me too.  Should I assume you're looking to take it?

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
