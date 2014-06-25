From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jun 2014 13:51:07 +0100
Subject: [PATCH 1/1] ARM: Kconfig.debug: Update Samsung UART config options
In-Reply-To: <03dd01cf906a$5e22b620$1a682260$@samsung.com>
References: <1403605171-31805-1-git-send-email-sachin.kamat@samsung.com>
 <03dd01cf906a$5e22b620$1a682260$@samsung.com>
Message-ID: <20140625125107.GJ32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 08:41:13PM +0900, Kukjin Kim wrote:
> Sachin Kamat wrote:
> > 
> + Russell
> 
> > In a multiplatform config, the low level debug option shows several
> > UART port entries. Improve the user visible string so that it becomes
> > clear to the user about Samsung UART ports.
> > While at it also remove some lines from the help text that are no
> > longer applicable across all Samsung platforms.
> > 
> Looks good to me and will apply into cleanup.

That's fine.  I don't have anything which clashes with this.  Thanks for
asking.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
