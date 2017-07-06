From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Jul 2017 16:16:07 +0100
Subject: [PATCH 0/2] ARM: add missing includes to header files
In-Reply-To: <20170704132542.27644-1-johan@kernel.org>
References: <20170704132542.27644-1-johan@kernel.org>
Message-ID: <20170706151607.GC23750@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 03:25:40PM +0200, Johan Hovold wrote:
> Add two missing include directives to two header files to avoid
> compile breakage when the required symbols have not already been
> defined.
> 
> The missing SCU include broke compilation of the (not-yet-merged)
> suspend support for am335x when !CONFIG_HAVE_ARM_SCU for example:
> 
> 	https://lkml.kernel.org/r/20170704131441.GH27842 at localhost

These look reasonable, please send them to the patch system for merging
after this merge window, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
